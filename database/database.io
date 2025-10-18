// Docs: https://dbml.dbdiagram.io/docs

Table follows {
  following_user_id uuid [not null]
  followed_user_id uuid [not null]
  created_at timestamp [not null]

  indexes {
    (following_user_id, followed_user_id) [unique]
  }
}

Table users {
  id uuid [pk]
  login text [not null]
  passwordHash varchar(32) [not null]
  created_at timestamp [not null]

  indexes {
    login [type: btree]
  }
}

Table posts {
  id uuid [pk]
  title text [not null]
  description text
  user_id uuid [not null]
  created_at timestamp [not null]
}

Table photos{
  id uuid [pk]
  post_id uuid [not null]
  url text [not null]
  created_at timestamp [not null]
}

Table hashTags{
  id uuid [pk]
  tag text [not null]

  indexes {
    tag [type: btree]
  }
}

Table comments{
  id uuid [pk]
  post_id uuid [not null]
  user_id uuid [not null]
  comment text [not null]
  created_at timestamp [not null]
}

Table reactions{
  id uuid [pk]
  reaction text [not null]
}

Table post_reactions {
  id uuid [pk]
  post_id uuid [not null]
  user_id uuid [not null]
  reaction_id uuid [not null]
  created_at timestamp [not null]

  indexes {
    post_id [type: btree]
    (post_id, user_id, reaction_id) [unique]
  }
}

Ref user_posts: posts.user_id > users.id

Ref: users.id < follows.following_user_id

Ref: users.id < follows.followed_user_id

Ref: posts.id < photos.post_id

Ref: posts.id <> hashTags.id

Ref: users.id < comments.user_id

Ref: posts.id < comments.post_id

Ref: users.id < post_reactions.user_id 
Ref: posts.id < post_reactions.post_id 
Ref: reactions.id < post_reactions.reaction_id