-- Seed login_platform
INSERT INTO login_platform (platform_name, created_at) VALUES
('montrack', now()),
('google', now()),
('apple', now()),
('facebook', now());

-- Seed trx_type
INSERT INTO trx_type (name, created_at) VALUES
('income', now()),
('expense', now());

-- Seed language
INSERT INTO language (language, created_at) VALUES
('English', now()),
('Bahasa Indonesia', now());

-- Seed users
INSERT INTO users (is_onboarded, email, password, pin, login_platform_id, token, created_at) VALUES
(TRUE, 'user1@example.com', 'hashedpassword1', '1234', 1, 'token123', now()),
(TRUE, 'user2@example.com', 'hashedpassword2', '5678', 2, 'token456', now());

-- Seed profile
INSERT INTO profile (name, quotes, language_id, avatar_url, user_id, created_at) VALUES
('User One', 'Keep it simple.', 1, 'https://avatar.example.com/1.png', 1, now()),
('User Two', 'Stay positive.', 2, 'https://avatar.example.com/2.png', 2, now());

-- Seed notifications
INSERT INTO notifications (headline, description, is_read, is_deleted, user_id, created_at) VALUES
('Welcome!', 'Thanks for joining.', FALSE, FALSE, 1, now()),
('Shopping budget has reached the limit', 'Better stop shopping modafucka', FALSE, FALSE, 1, now()),
('Update Available', 'New features added!', FALSE, FALSE, 2, now());

-- Seed wallet
INSERT INTO wallet (name, is_active, amount, user_id, created_at) VALUES
('Main Wallet', TRUE, 5000000, 1, now()),
('E-money', TRUE, 2000000, 1, now());

-- Seed pocket
INSERT INTO pocket (name, amount, description, emoji, is_reached, wallet_id, created_at) VALUES
('Gaming', 500000, 'Budget main', '🏖️', FALSE, 1, now()),
('Shopping', 1000000, 'Budget belanja slay', '💰', FALSE, 1, now());

-- Seed goal
INSERT INTO goal (name, amount, description, attachment_url, is_achieved, user_id, created_at) VALUES
('Buy a Lamborghini', 100000000000, 'Just for testing purpose', 'https://example.com/car.png', FALSE, 1, now());

-- Seed goal_trx
INSERT INTO goal_trx (name, date, amount, goal_id, created_at) VALUES
('Initial Deposit', now(), 1000, 1, now());

-- Seed pocket_trx
INSERT INTO pocket_trx (name, type_id, date, amount, pocket_id, description, attachment_url, created_at) VALUES
('Ke Warnet', 2, now(), 50000, 1, 'Main valorant', '', now());
INSERT INTO pocket_trx (name, type_id, date, amount, pocket_id, description, attachment_url, created_at) VALUES
('Ke Warnet lagi', 2, now(), 50000, 1, 'Main valorant lagi', '', now());
INSERT INTO pocket_trx (name, type_id, date, amount, pocket_id, description, attachment_url, created_at) VALUES
('Kerja ngepel', 1, now(), 25000, 1, 'Part time di cafe', '', now());
INSERT INTO pocket_trx (name, type_id, date, amount, pocket_id, description, attachment_url, created_at) VALUES
('Freelance ngoding', 1, now(), 250000, 2, 'Bikin landing page', '', now());

-- Seed constant
INSERT INTO constant (about_us, help_center, app_version) VALUES
('We are a finance app.', 'Contact us via chat.', '1.0');

-- Add `current_amount` to `goal`
ALTER TABLE goal
ADD COLUMN current_amount FLOAT DEFAULT 0;

-- Update existing rows to have 0 as the value
UPDATE goal
SET current_amount = 0
WHERE current_amount IS NULL;
