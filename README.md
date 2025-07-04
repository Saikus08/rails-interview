# rails-interview / TodoApi
## Build
To build the application:
`bin/setup`

## Run the API
To run the TodoApi in your local environment:
`bin/puma`

## Test
To run tests:
`bin/rspec`

# Documentation
Base URL: `http://127.0.0.1:3000`

---

## TodoLists

### Get All TodoLists
**GET** `/api/v1/todolists`

**Optional query params:**
- `page`: current page
- `per_page`: items per page

**Example:**
```bash
curl http://127.0.0.1:3000/api/v1/todolists?page=1&per_page=10
```

---

### Get One TodoList
**GET** `/api/v1/todolists/:id`

```bash
curl http://127.0.0.1:3000/api/v1/todolists/6
```

---

### Create TodoList
**POST** `/api/v1/todolists`

**Headers:**
- `Content-Type: application/json`

**Body:**
```json
{
  "todo_list": {
    "name": "Planificar entrevista",
    "description": "Preparar temas de Rails",
    "due_date": "2025-07-15T23:59:59Z",
    "status": "incomplete"
  }
}
```

---

### Update TodoList
**PATCH** `/api/v1/todolists/:id`

```json
{
  "todo_list": {
    "name": "Final Interview",
    "status": "completed"
  }
}
```

---

### Delete TodoList
**DELETE** `/api/v1/todolists/:id`

---

## TodoItems

### Get All Items from a TodoList
**GET** `/api/v1/todolists/:todo_list_id/items`

---

### Create TodoItem
**POST** `/api/v1/todolists/:todo_list_id/items`

```json
{
  "todo_item": {
    "title": "Revisar concerns en Rails",
    "description": "Ver ejemplos con ActiveSupport",
    "status": "to_do",
    "due_date": "2025-07-10T18:00:00Z"
  }
}
```

---

### Update TodoItem
**PATCH** `/api/v1/todolists/:todo_list_id/items/:id`

```json
{
  "todo_item": {
    "status": "done"
  }
}
```

---

### Bulk Update TodoItems
**PATCH** `/api/v1/todolists/:todo_list_id/items/bulk_update`

```json
{
  "todo_item_ids": [5, 2, 3],
  "status": "done"
}
```

---

## Hotwire View (HTML)

### View TodoList with Hotwire interaction
**GET** `/todolists/:id`

Example:
```bash
curl http://127.0.0.1:3000/todolists/1
```
- Complete all items without reloading HTML using Turbo Stream: `PATCH /todolists/:id/items/complete_all`
- Dynamic update of the completed and pending counters
- Reactive behavior with Stimulus (`todo-list#submit`)

---
