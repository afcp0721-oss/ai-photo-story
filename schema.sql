CREATE TABLE IF NOT EXISTS posts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_name TEXT NOT NULL,
  persona_type TEXT NOT NULL DEFAULT 'standard',
  title TEXT NOT NULL,
  story_content TEXT NOT NULL,
  tags TEXT,
  image_mime TEXT NOT NULL,
  image_data TEXT NOT NULL,
  taken_at TEXT,
  place TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_posts_created_at ON posts(created_at DESC);
