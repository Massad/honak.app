#!/usr/bin/env python3
"""Fix remaining Colors.white in ternary backgrounds and Colors.grey in helper functions."""

import re
import os

BASE = '/Users/omar/Documents/projects/super-app-jo/mobile'

def process_file(filepath):
    with open(filepath, 'r') as f:
        lines = f.readlines()

    changed = False
    for i, line in enumerate(lines):
        orig = line

        # Fix ": Colors.white," or ": Colors.white)" patterns (ternary false branch = unselected background)
        # But NOT if in stories/ (dark UI) or if it's text/icon color
        if 'stories/' in filepath:
            continue

        # Pattern: `: Colors.white,` or `: Colors.white)` — these are ternary false branches
        if re.search(r':\s*Colors\.white\s*[,)]', line):
            # Check if this is a color/decoration context (background)
            context_above = ''.join(l for l in lines[max(0,i-3):i+1])

            # Skip if it's textColor, foregroundColor on primary
            if any(kw in context_above for kw in ['textColor:', 'foregroundColor:', 'Icons.', 'TextStyle']):
                continue

            # Skip if it's inside a paint operation (qr_code_section)
            if 'paint' in context_above.lower():
                continue

            line = re.sub(r'Colors\.white(?=\s*[,)])', 'Theme.of(context).colorScheme.surface', line)

        if line != orig:
            lines[i] = line
            changed = True

    if changed:
        with open(filepath, 'w') as f:
            f.writelines(lines)
        print(f"  Fixed: {os.path.relpath(filepath, BASE)}")

    return changed

def main():
    import glob
    files = glob.glob(f'{BASE}/lib/features/business/**/*.dart', recursive=True)
    files = [f for f in files if '.freezed.dart' not in f and '.g.dart' not in f]

    count = 0
    for f in sorted(files):
        with open(f) as fh:
            if 'Colors.white' not in fh.read():
                continue
        if process_file(f):
            count += 1
    print(f"\nFixed {count} files")

if __name__ == '__main__':
    main()
