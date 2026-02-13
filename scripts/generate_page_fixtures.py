#!/usr/bin/env python3
"""
Reads all assets/api/pages/page_*.json files and generates:
  1. pages_list.json   — PageSummary for every page (explore grid, search, category browse)
  2. pages_manifest.json — Maps each page_id to its fixture path + business_type_id

Usage:
  python3 scripts/generate_page_fixtures.py
"""

import json
import sys
from pathlib import Path

PAGES_DIR = Path('assets/api/pages')
OUTPUT_LIST = PAGES_DIR / 'pages_list.json'
OUTPUT_MANIFEST = PAGES_DIR / 'pages_manifest.json'

# Fields to copy from page detail into the summary (pages_list.json)
SUMMARY_FIELDS = [
    'id', 'name', 'slug', 'avatar_url', 'cover_url',
    'business_type_name', 'business_type_id', 'explore_category',
    'archetype', 'engagement_level', 'is_open', 'store_type',
    'is_verified', 'is_following', 'followers_count',
    'trust_metrics', 'has_active_stories',
    'sub_category', 'claim_status', 'monthly_metric',
]

# Fixtures that are NOT business pages
SKIP_FILES = {'page_team_members.json'}


def build_summary(data: dict) -> dict:
    """Extract PageSummary fields from a full page detail fixture."""
    summary = {}
    for field in SUMMARY_FIELDS:
        if field in data:
            summary[field] = data[field]

    # Location: flatten to {area, city} for summary
    loc = data.get('location', {})
    if loc:
        summary['location'] = {
            'area': loc.get('area', ''),
            'city': loc.get('city', ''),
        }

    # Distance: use existing or default
    if 'distance' not in summary:
        summary['distance'] = None

    # Defaults for optional fields
    summary.setdefault('is_following', False)
    summary.setdefault('has_active_stories', False)
    summary.setdefault('monthly_metric', None)
    summary.setdefault('sub_category', None)
    summary.setdefault('trust_metrics', [])

    return summary


def main():
    if not PAGES_DIR.is_dir():
        print(f'Error: {PAGES_DIR} not found. Run from mobile/ root.', file=sys.stderr)
        sys.exit(1)

    page_files = sorted(
        f for f in PAGES_DIR.glob('page_*.json')
        if f.name not in SKIP_FILES
    )

    if not page_files:
        print('No page_*.json files found.', file=sys.stderr)
        sys.exit(1)

    summaries = []
    manifest = {}
    seen_ids = set()

    for filepath in page_files:
        with open(filepath, 'r', encoding='utf-8') as f:
            raw = json.load(f)

        data = raw.get('data', raw)
        page_id = data.get('id')
        biz_type = data.get('business_type_id', '')

        if not page_id:
            print(f'  Warning: {filepath.name} has no id, skipping')
            continue

        if page_id in seen_ids:
            print(f'  Warning: duplicate id "{page_id}" in {filepath.name}, skipping')
            continue
        seen_ids.add(page_id)

        # Fixture path without .json extension, relative to assets/api/
        fixture_name = f'pages/{filepath.stem}'

        # Manifest entry
        manifest[page_id] = {
            'page': fixture_name,
            'business_type_id': biz_type,
        }

        # Summary entry
        summaries.append(build_summary(data))

    # Sort summaries by follower count descending (most popular first)
    summaries.sort(key=lambda s: s.get('followers_count', 0), reverse=True)

    # Write pages_list.json
    pages_list = {
        'success': True,
        'data': summaries,
        'meta': {
            'page': 1,
            'per_page': 100,
            'total': len(summaries),
            'total_pages': 1,
        },
    }
    with open(OUTPUT_LIST, 'w', encoding='utf-8') as f:
        json.dump(pages_list, f, ensure_ascii=False, indent=2)
    print(f'Generated {OUTPUT_LIST} ({len(summaries)} pages)')

    # Sort manifest alphabetically
    sorted_manifest = dict(sorted(manifest.items()))
    with open(OUTPUT_MANIFEST, 'w', encoding='utf-8') as f:
        json.dump(sorted_manifest, f, ensure_ascii=False, indent=2)
    print(f'Generated {OUTPUT_MANIFEST} ({len(sorted_manifest)} entries)')


if __name__ == '__main__':
    main()
