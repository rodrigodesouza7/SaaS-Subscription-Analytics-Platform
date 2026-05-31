INSERT INTO plans (plan_name, monthly_price, yearly_price)
VALUES
('Starter', 29.90, 299.00),
('Professional', 79.90, 799.00),
('Business', 199.90, 1999.00),
('Enterprise', 499.90, 4999.00);

INSERT INTO customers (company_name, contact_name, email, country)
VALUES
('TechNova', 'Carlos Silva', 'carlos@technova.com', 'Brasil'),
('CloudSync', 'Ana Souza', 'ana@cloudsync.com', 'Brasil'),
('DataVision', 'John Smith', 'john@datavision.com', 'Estados Unidos'),
('SmartRetail', 'Maria Costa', 'maria@smartretail.com', 'Portugal'),
('HealthConnect', 'Pedro Santos', 'pedro@healthconnect.com', 'Brasil'),
('FinAnalytics', 'Robert Brown', 'robert@finanalytics.com', 'Canadá');

INSERT INTO subscriptions (customer_id, plan_id, start_date, end_date, status)
VALUES
(1, 2, '2026-01-01', NULL, 'active'),
(2, 3, '2026-01-15', NULL, 'active'),
(3, 4, '2026-02-01', NULL, 'active'),
(4, 1, '2026-02-10', '2026-05-10', 'canceled'),
(5, 2, '2026-03-01', NULL, 'active'),
(6, 3, '2026-03-20', NULL, 'active');

INSERT INTO invoices (subscription_id, invoice_date, amount, status)
VALUES
(1, '2026-05-01', 79.90, 'paid'),
(2, '2026-05-01', 199.90, 'paid'),
(3, '2026-05-01', 499.90, 'paid'),
(4, '2026-04-01', 29.90, 'paid'),
(5, '2026-05-01', 79.90, 'paid'),
(6, '2026-05-01', 199.90, 'paid');

INSERT INTO payments (invoice_id, payment_date, amount, payment_method)
VALUES
(1, '2026-05-02', 79.90, 'Credit Card'),
(2, '2026-05-02', 199.90, 'PIX'),
(3, '2026-05-03', 499.90, 'Bank Transfer'),
(4, '2026-04-02', 29.90, 'Credit Card'),
(5, '2026-05-02', 79.90, 'PIX'),
(6, '2026-05-03', 199.90, 'Credit Card');

INSERT INTO support_tickets (customer_id, priority, status, subject)
VALUES
(1, 'High', 'Open', 'API Integration Error'),
(2, 'Medium', 'Closed', 'Billing Question'),
(3, 'High', 'Open', 'Authentication Failure'),
(4, 'Low', 'Closed', 'Password Reset'),
(5, 'Medium', 'Open', 'Dashboard Loading Issue'),
(6, 'High', 'Closed', 'Payment Processing Error');