CREATE TABLE login_platform (
  id SERIAL PRIMARY KEY,
  platform_name VARCHAR,
  created_at TIMESTAMP,
  modified_at TIMESTAMP,
  deleted_at TIMESTAMP,
  created_by VARCHAR,
  modified_by VARCHAR,
  deleted_by VARCHAR
);

CREATE TABLE trx_type (
  id SERIAL PRIMARY KEY,
  name VARCHAR,
  created_at TIMESTAMP,
  modified_at TIMESTAMP,
  deleted_at TIMESTAMP,
  created_by VARCHAR,
  modified_by VARCHAR,
  deleted_by VARCHAR
);

CREATE TABLE language (
  id SERIAL PRIMARY KEY,
  language VARCHAR,
  created_at TIMESTAMP,
  modified_at TIMESTAMP,
  deleted_at TIMESTAMP,
  created_by VARCHAR,
  modified_by VARCHAR,
  deleted_by VARCHAR
);

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  is_onboarded BOOLEAN,
  email VARCHAR,
  password VARCHAR,
  pin VARCHAR,
  login_platform_id INT REFERENCES login_platform(id),
  token VARCHAR,
  created_at TIMESTAMP,
  modified_at TIMESTAMP,
  deleted_at TIMESTAMP,
  created_by VARCHAR,
  modified_by VARCHAR,
  deleted_by VARCHAR
);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_login_platform_id ON users(login_platform_id);

CREATE TABLE profile (
  id SERIAL PRIMARY KEY,
  name VARCHAR,
  quotes TEXT,
  language_id INT,
  avatar_url VARCHAR,
  user_id INT REFERENCES users(id),
  created_at TIMESTAMP,
  modified_at TIMESTAMP,
  deleted_at TIMESTAMP,
  created_by VARCHAR,
  modified_by VARCHAR,
  deleted_by VARCHAR
);
CREATE INDEX idx_profile_user_id ON profile(user_id);

CREATE TABLE notifications (
  id SERIAL PRIMARY KEY,
  headline TEXT,
  description TEXT,
  is_read BOOLEAN,
  is_deleted BOOLEAN,
  user_id INT REFERENCES users(id),
  created_at TIMESTAMP,
  modified_at TIMESTAMP,
  deleted_at TIMESTAMP,
  created_by VARCHAR,
  modified_by VARCHAR,
  deleted_by VARCHAR
);
CREATE INDEX idx_notifications_user_id ON notifications(user_id);
CREATE INDEX idx_notifications_is_read ON notifications(is_read);
CREATE INDEX idx_notifications_is_deleted ON notifications(is_deleted);

CREATE TABLE wallet (
  id SERIAL PRIMARY KEY,
  name VARCHAR,
  is_active BOOLEAN,
  amount FLOAT,
  currency VARCHAR,
  user_id INT REFERENCES users(id),
  created_at TIMESTAMP,
  modified_at TIMESTAMP,
  deleted_at TIMESTAMP,
  created_by VARCHAR,
  modified_by VARCHAR,
  deleted_by VARCHAR
);
CREATE INDEX idx_wallet_user_id ON wallet(user_id);
CREATE INDEX idx_wallet_is_active ON wallet(is_active);

CREATE TABLE pocket (
  id SERIAL PRIMARY KEY,
  name VARCHAR,
  amount FLOAT,
  description TEXT,
  emoji VARCHAR,
  is_reached BOOLEAN,
  wallet_id INT REFERENCES wallet(id),
  created_at TIMESTAMP,
  modified_at TIMESTAMP,
  deleted_at TIMESTAMP,
  created_by VARCHAR,
  modified_by VARCHAR,
  deleted_by VARCHAR
);
CREATE INDEX idx_pocket_wallet_id ON pocket(wallet_id);
CREATE INDEX idx_pocket_is_reached ON pocket(is_reached);

CREATE TABLE goal (
  id SERIAL PRIMARY KEY,
  name VARCHAR,
  amount FLOAT,
  description TEXT,
  attachment_url VARCHAR,
  is_achieved BOOLEAN,
  user_id INT REFERENCES users(id),
  created_at TIMESTAMP,
  modified_at TIMESTAMP,
  deleted_at TIMESTAMP,
  created_by VARCHAR,
  modified_by VARCHAR,
  deleted_by VARCHAR
);
CREATE INDEX idx_goal_user_id ON goal(user_id);
CREATE INDEX idx_goal_is_achieved ON goal(is_achieved);

CREATE TABLE goal_trx (
  id SERIAL PRIMARY KEY,
  name VARCHAR,
  date TIMESTAMP,
  amount FLOAT,
  goal_id INT REFERENCES goal(id),
  created_at TIMESTAMP,
  modified_at TIMESTAMP,
  deleted_at TIMESTAMP,
  created_by VARCHAR,
  modified_by VARCHAR,
  deleted_by VARCHAR
);
CREATE INDEX idx_goal_trx_goal_id ON goal_trx(goal_id);

CREATE TABLE pocket_trx (
  id SERIAL PRIMARY KEY,
  name VARCHAR,
  type_id INT REFERENCES trx_type(id),
  date TIMESTAMP,
  amount FLOAT,
  pocket_id INT REFERENCES pocket(id),
  description TEXT,
  attachment_url VARCHAR,
  created_at TIMESTAMP,
  modified_at TIMESTAMP,
  deleted_at TIMESTAMP,
  created_by VARCHAR,
  modified_by VARCHAR,
  deleted_by VARCHAR
);
CREATE INDEX idx_pocket_trx_pocket_id ON pocket_trx(pocket_id);
CREATE INDEX idx_pocket_trx_type_id ON pocket_trx(type_id);

CREATE TABLE constant (
  id SERIAL PRIMARY KEY,
  about_us TEXT,
  help_center TEXT,
  app_version VARCHAR
);

-- Add `current_usage` to `pocket`
ALTER TABLE pocket
ADD COLUMN current_usage FLOAT DEFAULT 0;

-- Update existing rows to have 0 as the value
UPDATE pocket
SET current_usage = 0
WHERE current_usage IS NULL;

