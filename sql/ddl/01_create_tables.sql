CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    company_name VARCHAR(200) NOT NULL,
    contact_name VARCHAR(150),
    email VARCHAR(255) UNIQUE,
    country VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE plans (
    plan_id SERIAL PRIMARY KEY,
    plan_name VARCHAR(100) NOT NULL,
    monthly_price NUMERIC(10,2) NOT NULL,
    yearly_price NUMERIC(10,2)
);

CREATE TABLE subscriptions (
    subscription_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    plan_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    status VARCHAR(30) NOT NULL,
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),
    FOREIGN KEY (plan_id)
        REFERENCES plans(plan_id)
);

CREATE TABLE invoices (
    invoice_id SERIAL PRIMARY KEY,
    subscription_id INT NOT NULL,
    invoice_date DATE NOT NULL,
    amount NUMERIC(10,2) NOT NULL,
    status VARCHAR(30) NOT NULL,
    FOREIGN KEY (subscription_id)
        REFERENCES subscriptions(subscription_id)
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    invoice_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount NUMERIC(10,2) NOT NULL,
    payment_method VARCHAR(50),
    FOREIGN KEY (invoice_id)
        REFERENCES invoices(invoice_id)
);

CREATE TABLE support_tickets (
    ticket_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    opened_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    priority VARCHAR(20),
    status VARCHAR(20),
    subject VARCHAR(255),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

CREATE TABLE subscription_audit (
    audit_id SERIAL PRIMARY KEY,
    subscription_id INT NOT NULL,
    old_status VARCHAR(30),
    new_status VARCHAR(30),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);