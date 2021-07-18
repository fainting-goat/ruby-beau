json.extract! dog, :id, :name, :age, :birthday, :is_best_dog, :created_at, :updated_at
json.url dog_url(dog, format: :json)
