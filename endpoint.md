# Endpoints

## There Are Three Basic Endpoint Categories:

- Model Endpoints
- Relationship Endpoints
- Business Intelligence Queries

---
### Model Endpoints:

#### Indexes

To render the JSON data in index form go to the following URIs:
```
api/v1/customers
api/v1/invoice_items
api/v1/invoices
api/v1/items
api/v1/merchants
api/v1/transactions
```

#### Specific Resources

To render a specific JSON object:

- At each of the endpoints add a specific id to the end of the previous URI. An example would be:
```
api/v1/customer/88
```
- In a more general format:
```
api/v1/resource/id
```

---
### Relationship Endpoints

To render JSON where the resource belongs to another resource, aim your browser at the following endpoints:

- Customers
```
/api/v1/customers/:id/invoices
/api/v1/customers/:id/transactions
```
- Invoice Items
```
/api/v1/invoice_items/:id/invoice
/api/v1/invoice_items/:id/item
```
- Invoices
```
/api/v1/invoices/:id/customer
/api/v1/invoices/:id/invoice_items
/api/v1/invoices/:id/items
/api/v1/invoices/:id/merchant
/api/v1/invoices/:id/transactions
```
- Items
```
/api/v1/items/:id/invoice_items
/api/v1/items/:id/invoices
/api/v1/items/:id/merchant
```
- Merchants
```
/api/v1/merchants/:id/invoices
/api/v1/merchants/:id/items
```
- Transactions
```
/api/v1/transactions/:id/invoice
```

---
### Business Intelligence

These endpoints give access to information on business analytics. Anytime you see an 'x' it is a variable where you can pass your own value.

- Customers
```
/api/v1/customers/:id/favorite_merchant
```

- Items
```
/api/v1/items/:id/best_day
/api/v1/items/most_items?quantity=x
/api/v1/items/most_revenue?quantity=x
```

- Merchant
```
/api/v1/merchants/:id/revenue
/api/v1/merchants/:id/revenue?date=x
/api/v1/merchants/:id/favorite_customer
/api/v1/merchants/:id/customers_with_pending_invoices
```
