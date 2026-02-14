#!/usr/bin/env python3
"""Fix errors from color migration:
1. Remove context_ext import from part files
2. Revert Theme.of(context) in non-widget functions (no BuildContext available)
3. Remove const from expressions containing Theme.of(context)
"""

import re
import subprocess
import sys

BASE = '/Users/omar/Documents/projects/super-app-jo/mobile'

def get_errors():
    """Run flutter analyze and parse errors."""
    result = subprocess.run(
        ['flutter', 'analyze', 'lib/features/business/'],
        capture_output=True, text=True, cwd=BASE
    )
    errors = []
    for line in result.stdout.split('\n'):
        m = re.match(r'\s+error\s+•\s+(.+?)\s+•\s+(.+?):(\d+):\d+\s+•\s+(\S+)', line)
        if m:
            errors.append({
                'message': m.group(1),
                'file': m.group(2),
                'line': int(m.group(3)),
                'code': m.group(4),
            })
    return errors

def fix_part_file_imports(filepath):
    """Remove import added to part files."""
    with open(f'{BASE}/{filepath}', 'r') as f:
        content = f.read()

    # Remove the context_ext import line
    content = content.replace("import 'package:honak/core/extensions/context_ext.dart';\n", '')

    with open(f'{BASE}/{filepath}', 'w') as f:
        f.write(content)
    print(f"  Fixed part file import: {filepath}")

def fix_undefined_context(filepath, line_num):
    """Revert Theme.of(context) back to hardcoded color in functions without context."""
    full_path = f'{BASE}/{filepath}'
    with open(full_path, 'r') as f:
        lines = f.readlines()

    idx = line_num - 1
    if idx >= len(lines):
        return

    line = lines[idx]

    # Map back from Theme.of(context).colorScheme.X to Colors equivalent
    replacements = {
        'Theme.of(context).colorScheme.surfaceContainerLowest': 'Colors.grey.shade50',
        'Theme.of(context).colorScheme.surfaceContainerLow': 'Colors.grey.shade100',
        'Theme.of(context).colorScheme.surfaceContainer': 'Colors.grey.shade200',
        'Theme.of(context).colorScheme.outlineVariant': 'Colors.grey.shade200',
        'Theme.of(context).colorScheme.outline': 'Colors.grey.shade300',
        'Theme.of(context).colorScheme.onSurfaceVariant': 'Colors.grey.shade500',
        'Theme.of(context).colorScheme.onSurface': 'Colors.black',
        'Theme.of(context).colorScheme.surface': 'Colors.white',
    }

    for theme_val, colors_val in replacements.items():
        if theme_val in line:
            lines[idx] = line.replace(theme_val, colors_val)
            print(f"  Reverted {filepath}:{line_num} (no context available)")
            break

    with open(full_path, 'w') as f:
        f.writelines(lines)

def fix_const_error(filepath, line_num):
    """Remove const keyword from the expression at or before the given line."""
    full_path = f'{BASE}/{filepath}'
    with open(full_path, 'r') as f:
        lines = f.readlines()

    # The error is at the Theme.of(context) call, but const is earlier
    # Search backwards from error line for const keyword
    idx = line_num - 1

    # First check the same line
    line = lines[idx]
    if 'const ' in line and 'Theme.of' in line:
        lines[idx] = line.replace('const ', '', 1)
        with open(full_path, 'w') as f:
            f.writelines(lines)
        print(f"  Removed const: {filepath}:{line_num}")
        return

    # Search backwards up to 20 lines for the const that wraps this expression
    for back in range(0, min(20, idx + 1)):
        check_idx = idx - back
        check_line = lines[check_idx]
        if 'const ' in check_line:
            # Remove first const on this line
            lines[check_idx] = check_line.replace('const ', '', 1)
            with open(full_path, 'w') as f:
                f.writelines(lines)
            print(f"  Removed const: {filepath}:{check_idx + 1}")
            return

    print(f"  WARNING: Could not find const to remove for {filepath}:{line_num}")

def main():
    print("Getting errors...")
    errors = get_errors()
    print(f"Found {len(errors)} errors")

    # Fix part file imports first
    part_files = set()
    for e in errors:
        if e['code'] == 'non_part_of_directive_in_part':
            part_files.add(e['file'])
    for f in part_files:
        fix_part_file_imports(f)

    # Fix undefined context — revert those lines
    for e in errors:
        if e['code'] == 'undefined_identifier' and 'context' in e['message'].lower():
            fix_undefined_context(e['file'], e['line'])

    # Fix const errors — need multiple passes since removing const can cascade
    for iteration in range(5):
        print(f"\nConst fix pass {iteration + 1}...")
        errors = get_errors()
        const_errors = [e for e in errors if e['code'] in ('const_eval_method_invocation', 'invalid_constant')]
        if not const_errors:
            print("No more const errors!")
            break
        print(f"  {len(const_errors)} const errors remaining")
        for e in const_errors:
            fix_const_error(e['file'], e['line'])

if __name__ == '__main__':
    main()
