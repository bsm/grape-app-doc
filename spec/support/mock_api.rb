module MockAPI
  class V1 < Grape::API
    prefix  '/a'
    version 'v1'

    desc 'Returns the service status' do
      success [:no_content, 'Up']
      failure [[503, 'Down']]
      headers XAdminToken: { description: 'Valdates your identity', required: true }
    end
    get '/status' do
      status 204
    end

    resource 'posts' do

      desc 'Returns a list of posts' do
        success Post::Entity
      end
      params do
        optional :sort, type: Hash, documentation: { desc: "Sort order" } do
          requires :col, values: ['id', 'title'], documentation: { desc: "Sort column" }
          optional :dir, values: ['asc', 'desc'], default: 'asc', documentation: { desc: "Sort direction" }
        end
        optional :search, type: String, documentation: { desc: "search string" }
      end
      get '' do
        present [Post.new, Post.new]
      end

      desc 'Returns a post' do
        success [200, "Found", Post::Entity]
        failure [[404, 'Not found']]
      end
      get ':id' do
        present Post.new
      end

      desc 'Creates a post' do
        success [:created, "Created"]
        failure [
          [400, 'Validation failed', ValidationErrors::Entity],
          [401, 'Bad API token'],
        ]
      end
      params do
        requires :title, documentation: { desc: "A title" }
        requires :author, type: Hash, documentation: { desc: "The author attributes" } do
          requires :name, :email
        end
        optional :status, values: ['draft', 'live'], default: 'draft'
      end
      post '' do
        status :created
      end

    end
  end
end

Grape::App.mount MockAPI::V1
