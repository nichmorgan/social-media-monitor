-- Social Media Monitoring Database Schema

-- Table for storing social media posts
CREATE TABLE IF NOT EXISTS social_posts (
    id SERIAL PRIMARY KEY,
    platform VARCHAR(50) NOT NULL,
    post_id VARCHAR(255) UNIQUE NOT NULL,
    author_username VARCHAR(255),
    author_display_name VARCHAR(255),
    content TEXT NOT NULL,
    post_url VARCHAR(500),
    published_at TIMESTAMP WITH TIME ZONE,
    scraped_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    language VARCHAR(10),
    follower_count INTEGER,
    engagement_count INTEGER,
    like_count INTEGER,
    share_count INTEGER,
    comment_count INTEGER,
    raw_data JSONB
);

-- Table for storing sentiment analysis results
CREATE TABLE IF NOT EXISTS sentiment_analysis (
    id SERIAL PRIMARY KEY,
    post_id INTEGER REFERENCES social_posts(id) ON DELETE CASCADE,
    sentiment_score DECIMAL(3,2), -- -1.00 to 1.00
    sentiment_label VARCHAR(20), -- positive, negative, neutral
    confidence_score DECIMAL(3,2), -- 0.00 to 1.00
    analyzed_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    analysis_model VARCHAR(100),
    raw_sentiment_data JSONB
);

-- Table for storing intent analysis results
CREATE TABLE IF NOT EXISTS intent_analysis (
    id SERIAL PRIMARY KEY,
    post_id INTEGER REFERENCES social_posts(id) ON DELETE CASCADE,
    intent_category VARCHAR(50),
    intent_confidence DECIMAL(3,2), -- 0.00 to 1.00
    intent_subcategory VARCHAR(100),
    analyzed_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    analysis_model VARCHAR(100),
    raw_intent_data JSONB
);

-- Table for tracking monitored topics and keywords
CREATE TABLE IF NOT EXISTS monitoring_topics (
    id SERIAL PRIMARY KEY,
    topic_name VARCHAR(100) NOT NULL,
    keywords TEXT[], -- Array of keywords
    hashtags TEXT[], -- Array of hashtags
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table for mapping posts to topics
CREATE TABLE IF NOT EXISTS post_topics (
    id SERIAL PRIMARY KEY,
    post_id INTEGER REFERENCES social_posts(id) ON DELETE CASCADE,
    topic_id INTEGER REFERENCES monitoring_topics(id) ON DELETE CASCADE,
    relevance_score DECIMAL(3,2), -- 0.00 to 1.00
    matched_keywords TEXT[],
    matched_hashtags TEXT[],
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(post_id, topic_id)
);

-- Table for storing alerts and notifications
CREATE TABLE IF NOT EXISTS alerts (
    id SERIAL PRIMARY KEY,
    post_id INTEGER REFERENCES social_posts(id) ON DELETE CASCADE,
    alert_type VARCHAR(50), -- sentiment_threshold, viral_content, keyword_spike
    alert_level VARCHAR(20), -- low, medium, high, critical
    message TEXT,
    is_sent BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    sent_at TIMESTAMP WITH TIME ZONE
);

-- Table for storing daily analytics summaries
CREATE TABLE IF NOT EXISTS daily_analytics (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    topic_id INTEGER REFERENCES monitoring_topics(id) ON DELETE CASCADE,
    total_posts INTEGER DEFAULT 0,
    positive_sentiment_count INTEGER DEFAULT 0,
    negative_sentiment_count INTEGER DEFAULT 0,
    neutral_sentiment_count INTEGER DEFAULT 0,
    avg_sentiment_score DECIMAL(3,2),
    top_intent_categories JSONB,
    total_engagement INTEGER DEFAULT 0,
    viral_posts_count INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(date, topic_id)
);

-- Indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_social_posts_platform ON social_posts(platform);
CREATE INDEX IF NOT EXISTS idx_social_posts_published_at ON social_posts(published_at);
CREATE INDEX IF NOT EXISTS idx_social_posts_scraped_at ON social_posts(scraped_at);
CREATE INDEX IF NOT EXISTS idx_sentiment_analysis_sentiment_score ON sentiment_analysis(sentiment_score);
CREATE INDEX IF NOT EXISTS idx_intent_analysis_intent_category ON intent_analysis(intent_category);
CREATE INDEX IF NOT EXISTS idx_post_topics_relevance_score ON post_topics(relevance_score);
CREATE INDEX IF NOT EXISTS idx_alerts_alert_level ON alerts(alert_level);
CREATE INDEX IF NOT EXISTS idx_alerts_is_sent ON alerts(is_sent);
CREATE INDEX IF NOT EXISTS idx_daily_analytics_date ON daily_analytics(date);

-- Function to automatically update post topics based on content
CREATE OR REPLACE FUNCTION update_post_topics()
RETURNS TRIGGER AS $$
BEGIN
    -- This will be implemented in n8n workflows
    -- Placeholder for topic matching logic
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to automatically analyze new posts
CREATE TRIGGER trigger_update_post_topics
    AFTER INSERT ON social_posts
    FOR EACH ROW
    EXECUTE FUNCTION update_post_topics();