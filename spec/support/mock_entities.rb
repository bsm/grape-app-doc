class ValidationErrors < Array
  def errors
    self
  end

  class Entity < Grape::Entity
    expose :errors, documentation: { type: "String[]", desc: "Validation errors" }
  end
end

class Author
  def name
    "Alice Smith"
  end

  def email
    "alice.smith@example.com"
  end

  class Entity < Grape::Entity
    expose :name, documentation: { type: "String", desc: "A name" }
    expose :email, documentation: { type: "String", desc: "The email address" }
  end
end

class Comment
  def comment
    "A shared opinion"
  end

  def author
    Author.new
  end

  class Entity < Grape::Entity
    expose :comment, documentation: { type: "String", desc: "The comment" }
    expose :author, using: Author::Entity, documentation: { type: "Author", desc: "The comment author" }
  end
end

class Post
  def id
    33
  end

  def title
    "A post title"
  end

  def author
    Author.new
  end

  def comments
    @comments ||= [Comment.new, Comment.new]
  end

  def status
    "live"
  end

  class Entity < Grape::Entity
    expose :id, documentation: { type: "Integer", desc: "Unique identifier" }
    expose :title, documentation: { type: "String", desc: "A friendly title" }
    expose :author, using: Author::Entity, documentation: { type: "Author", desc: "The author" }
    expose :comments, using: Comment::Entity, documentation: { type: "Comment[]", desc: "Comments associatated with this post" }
    expose :status, documentation: { type: "String", values: ['draft', 'live'], default: 'draft', description: "The status" }
  end
end
