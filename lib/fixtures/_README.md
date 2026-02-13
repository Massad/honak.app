# Fixtures

Mock JSON data for local development and UI prototyping. These files simulate API responses before the backend is ready.

## File to API Endpoint Mapping

| Fixture File | API Endpoint | Description |
|---|---|---|
| `users.json` | `GET /v1/users/:id` | User profiles |
| `business_types.json` | `GET /v1/business-types` | Admin-managed business type catalog |
| `pages.json` | `GET /v1/pages`, `GET /v1/pages/:slug` | Business pages (profiles) |
| `categories.json` | `GET /v1/pages/:id/categories` | Product categories per page |
| `products.json` | `GET /v1/pages/:id/products` | Products listed by a page |
| `orders.json` | `GET /v1/orders`, `GET /v1/orders/:id` | User orders (all statuses) |
| `posts.json` | `GET /v1/feed`, `GET /v1/pages/:id/posts` | Feed posts from followed pages |
| `chats.json` | `GET /v1/chats` | Chat conversation list |
| `notifications.json` | `GET /v1/notifications` | User notifications |

## Data Format Conventions

- **Prices**: Integer piasters (Jordanian cents). `250` = 2.50 JOD. Never use floats.
- **Timestamps**: Unix epoch seconds (e.g., `1700000000` = Nov 14, 2023 UTC).
- **IDs**: Short prefixed strings (`usr_`, `pg_`, `prd_`, `ord_`, `pst_`, `cat_`, `cht_`, `ntf_`, `bt_`).
- **Language**: All user-facing text is Arabic. Business type names include `name_en` for internal use.
- **Images**: Placeholder URLs via `picsum.photos` with deterministic seeds.

## Order Statuses

`pending` -> `confirmed` -> `preparing` -> `ready` -> `delivering` -> `delivered`

Orders can also be `cancelled` from any pre-delivery status.

## How to Add New Fixtures

1. Create a new JSON file in this directory (e.g., `reviews.json`).
2. Follow existing conventions: prefixed IDs, piasters for money, epoch seconds for timestamps.
3. Reference existing IDs for foreign keys (e.g., use `page_id` values from `pages.json`).
4. Add the mapping to the table above.
5. Keep data realistic for the Jordanian market (Arabic names, JOD pricing, local areas).

## Edge Cases Included

- Empty descriptions (`pg_gr03`, several products)
- Zero followers (`pg_gr03`)
- Zero products (`pg_cl05`)
- Unavailable product (`prd_013` cheesecake)
- Products with size/color variants (`prd_003`, `prd_011`, `prd_033`, `prd_041`)
- Cancelled order with cancellation note (`ord_008`)
- Posts with no media, single image, and multiple images
- Mix of read/unread notifications
- Chats with zero and nonzero unread counts
- Verified and unverified business pages
