#!/usr/bin/env python3
"""Migrate hardcoded Colors to theme-aware colorScheme in business/ directory."""

import re
import sys
import os

CONTEXT_EXT_IMPORT = "import 'package:honak/core/extensions/context_ext.dart';"

def needs_context_ext(content):
    return 'context_ext.dart' not in content

def add_context_ext_import(content):
    """Add context_ext import after the last existing import."""
    if not needs_context_ext(content):
        return content
    # Find last import line
    lines = content.split('\n')
    last_import_idx = 0
    for i, line in enumerate(lines):
        if line.startswith('import '):
            last_import_idx = i
    lines.insert(last_import_idx + 1, CONTEXT_EXT_IMPORT)
    return '\n'.join(lines)

def remove_const_from_line(line):
    """Remove const keyword if present at widget construction."""
    # This is tricky - we'll handle const removal separately
    return line

def migrate_file(filepath):
    with open(filepath, 'r') as f:
        content = f.read()

    original = content

    # Track if we made changes
    changes = []

    lines = content.split('\n')
    new_lines = []
    need_import = False

    for i, line in enumerate(lines):
        orig_line = line

        # Skip shadow/overlay usages
        if 'withOpacity' in line or 'withValues' in line:
            new_lines.append(line)
            continue

        # === Colors.grey replacements ===

        # grey.shade50 → surfaceContainerLowest
        line = re.sub(r'Colors\.grey\.shade50\b', 'Theme.of(context).colorScheme.surfaceContainerLowest', line)

        # grey.shade100 as border → outlineVariant
        if re.search(r'Colors\.grey\.shade100', line):
            if any(kw in line.lower() for kw in ['border', 'borderside', 'border.all', 'divider']):
                line = re.sub(r'Colors\.grey\.shade100', 'Theme.of(context).colorScheme.outlineVariant', line)
            else:
                # Container/background
                line = re.sub(r'Colors\.grey\.shade100', 'Theme.of(context).colorScheme.surfaceContainerLow', line)

        # grey.shade200
        if re.search(r'Colors\.grey\.shade200', line):
            if any(kw in line.lower() for kw in ['border', 'borderside', 'border.all', 'divider', 'separator']):
                line = re.sub(r'Colors\.grey\.shade200', 'Theme.of(context).colorScheme.outlineVariant', line)
            elif 'enabled' in line or 'disable' in line.lower():
                line = re.sub(r'Colors\.grey\.shade200', 'Theme.of(context).colorScheme.outlineVariant', line)
            else:
                line = re.sub(r'Colors\.grey\.shade200', 'Theme.of(context).colorScheme.outlineVariant', line)

        # grey.shade300
        if re.search(r'Colors\.grey\.shade300', line):
            line = re.sub(r'Colors\.grey\.shade300', 'Theme.of(context).colorScheme.outline', line)

        # grey.shade400
        if re.search(r'Colors\.grey\.shade400', line):
            line = re.sub(r'Colors\.grey\.shade400', 'Theme.of(context).colorScheme.onSurfaceVariant', line)

        # grey.shade500
        if re.search(r'Colors\.grey\.shade500', line):
            line = re.sub(r'Colors\.grey\.shade500', 'Theme.of(context).colorScheme.onSurfaceVariant', line)

        # grey.shade600
        if re.search(r'Colors\.grey\.shade600', line):
            line = re.sub(r'Colors\.grey\.shade600', 'Theme.of(context).colorScheme.onSurfaceVariant', line)

        # grey.shade700
        if re.search(r'Colors\.grey\.shade700', line):
            line = re.sub(r'Colors\.grey\.shade700', 'Theme.of(context).colorScheme.onSurface', line)

        # grey.shade800, shade900
        if re.search(r'Colors\.grey\.shade[89]00', line):
            line = re.sub(r'Colors\.grey\.shade[89]00', 'Theme.of(context).colorScheme.onSurface', line)

        # Colors.grey (no shade)
        if re.search(r'Colors\.grey\b(?!\.)', line):
            line = re.sub(r'Colors\.grey\b(?!\.)', 'Theme.of(context).colorScheme.onSurfaceVariant', line)

        # === Colors.black (non-shadow) ===
        if re.search(r'Colors\.black\b', line) and 'withOpacity' not in line and 'withValues' not in line:
            line = re.sub(r'Colors\.black\b', 'Theme.of(context).colorScheme.onSurface', line)

        # === Colors.white ===
        if re.search(r'Colors\.white\b', line):
            # Check context: is it on a primary/colored background?
            # Look at surrounding lines for AppColors.primary or similar
            context_lines = '\n'.join(lines[max(0,i-5):i+5])
            on_primary = any(kw in context_lines for kw in ['AppColors.primary', 'AppColors.success', 'AppColors.error', 'AppColors.warning'])

            # Check if this is icon/text color (likely on primary bg)
            is_text_or_icon = any(kw in line for kw in ['TextStyle', 'Icon(', 'icon:', 'Icons.'])

            # If on a primary background or is text/icon that's likely on colored bg
            if on_primary and is_text_or_icon:
                pass  # KEEP Colors.white
            elif 'isActive' in line or 'isSelected' in line or 'selected' in line.lower():
                pass  # Conditional - likely white on active/primary, keep
            elif any(kw in line.lower() for kw in ['decoration', 'color:', 'backgroundcolor', 'fillcolor', 'bgcolor']):
                # Background color
                if is_text_or_icon:
                    pass  # Keep - text/icon color, probably on colored bg
                else:
                    line = re.sub(r'Colors\.white\b', 'Theme.of(context).colorScheme.surface', line)
            else:
                # Default: if it looks like a background, migrate; otherwise keep
                if 'color: Colors.white' in line and not is_text_or_icon:
                    line = re.sub(r'Colors\.white\b', 'Theme.of(context).colorScheme.surface', line)

        if line != orig_line:
            need_import = True
            # Remove const from this line if present
            line = re.sub(r'\bconst\s+(TextStyle|Icon|EdgeInsets|BoxDecoration|BorderSide)\(', r'\1(', line)
            changes.append((i+1, orig_line.strip(), line.strip()))

        new_lines.append(line)

    if not changes:
        return False

    content = '\n'.join(new_lines)

    # Add import if needed
    if need_import and needs_context_ext(content):
        content = add_context_ext_import(content)

    # Remove const from widgets that now contain Theme.of(context) calls
    # This needs multi-line awareness - remove const before Container, Row, Column etc
    # that contain Theme.of(context) in their subtree
    # For now, just remove const on lines with Theme.of
    content = re.sub(r'const\s+(TextStyle\(.*?Theme\.of)', r'\1', content)
    content = re.sub(r'const\s+(Icon\(.*?Theme\.of)', r'\1', content)
    content = re.sub(r'const\s+(EdgeInsets.*?Theme\.of)', r'\1', content)

    with open(filepath, 'w') as f:
        f.write(content)

    print(f"  {os.path.basename(filepath)}: {len(changes)} changes")
    return True

def main():
    import glob
    base = '/Users/omar/Documents/projects/super-app-jo/mobile/lib/features/business'
    files = glob.glob(f'{base}/**/*.dart', recursive=True)
    files = [f for f in files if '.freezed.dart' not in f and '.g.dart' not in f]

    total_files = 0
    for filepath in sorted(files):
        # Check if file has any hardcoded colors
        with open(filepath, 'r') as f:
            content = f.read()
        if not re.search(r'Colors\.(white|grey|black)', content):
            continue
        if migrate_file(filepath):
            total_files += 1

    print(f"\nMigrated {total_files} files")

if __name__ == '__main__':
    main()
