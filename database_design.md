# Mobile App Developer Assignment - Part 2



## Part 2: Process and Database Design

### Database Choice and Justification

I have chosen **MySQL** as the backend database for this app because:
- It is relational, structured, and works well for apps that require clear data relationships (like users and their saved articles)
- It's widely supported, reliable, and easy to integrate with backend frameworks
- Perfect for read-heavy mobile apps (like browsing articles)
- Well-documented and efficient for prototyping mobile app backends

### Database Schema

#### 1. users table
Stores login credentials and basic user info.
```sql
CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  name VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### 2. articles table
Stores article content to display in the app.
```sql
CREATE TABLE articles (
  id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  author VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### 3. favorites table
Stores which user has favorited which article.
```sql
CREATE TABLE favorites (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  article_id INT,
  favorited_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (article_id) REFERENCES articles(id)
);
```

### ER Diagram (Text Format)

```
users ───────┐
             │
             │     favorites
             └──── user_id ─────┐
                                │
                      articles ◄┘
```

- A user can favorite many articles
- An article can be favorited by many users
- The favorites table connects them (many-to-many)

### Authentication Flow

#### Sign Up:
1. User enters name, email, password
2. Backend checks if email already exists
3. Password is hashed (e.g., using bcrypt)
4. Record created in users table
5. Response sent back (success or error)

#### Login:
1. User enters email and password
2. Backend looks up user by email
3. Compares entered password with stored hash
4. If correct, login is successful
5. Optional: set a session or token for frontend

### Process Flows

#### View/Update Profile
- `GET /profile`: Fetch user info from users table
- `POST /profile`: Update name or email

#### Save Favorite Article
- `POST /favorites`: Add a row in favorites table (user_id, article_id)
- `GET /favorites`: Show all articles favorited by a user
- `DELETE /favorites/:id`: Remove a favorite

### Why This Design Works

- Keeps things simple and relational
- Perfect for mobile apps needing basic user management and content interaction
- Easy to scale if needed later
- Easy to build UI flows from this (sign up → login → home → favorite)
