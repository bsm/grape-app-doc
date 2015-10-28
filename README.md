# Grape::App::Doc

Currently, its experimental work-in-progress. Do not use!

## Documentation Guidelines

1. Each API endpoint must have a `success` description, referencing an entity class. Example:
  ```ruby
  desc "List" do
    success Post::Entity
  end
  get '/posts' do
    present Post.all
  end
  ```
2. Each entity exposure should have documentation
3. Tntity exposure type must be declared as a class. Example:
  ```ruby
  class Post::Entity < Grape::Entity
    expose :title, documentation: { type: String, desc: "Status update text." }
  end
  ```
4. Entity exposure documentation may contain the following keys: `type`, `desc`, `required`, `is_array`, `values`, `default`
5. TODO: more

## Licence

```
Copyright (c) 2015 Black Square Media

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
