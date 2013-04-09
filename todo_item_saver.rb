### Not shown in blog post
require 'rspec/autorun'

class TodoItem
end

class TodoList
end

####


class TodoSaver
  def initialize list_name, todo_text
    @list_name = list_name
    @todo_text = todo_text
  end

  def save
    todo = TodoItem.create(@todo_text)
    todo_list.add todo
  end

  def todo_list
    TodoList.retrieve(@list_name.downcase) ||
      TodoList.create(@list_name)
  end
end

describe TodoSaver do
  describe '#save' do
    it 'creates the todo and adds it to a list' do
      todo_list, todo = mock, mock
      saver = TodoSaver.new('Writing', 'write blogpost')
      saver.stub todo_list: todo_list

      TodoItem.should_receive(:create).with('write blogpost')
              .and_return(todo)
      todo_list.should_receive(:add).with(todo)

      saver.save()
    end
  end
  describe '#todo_list' do
    it 'retrieves an existing list by its normalized name' do
      todo_list = mock
      saver = TodoSaver.new('WriTing', mock)
      TodoList.stub(:retrieve).with('writing').and_return(todo_list)

      expect(saver.todo_list).to eq todo_list
    end
    it 'creates a new list if no previous list was found' do
      todo_list = mock
      saver = TodoSaver.new('WriTing', mock)
      TodoList.stub(:retrieve).with('writing').and_return(nil)
      TodoList.stub(:create).with('WriTing').and_return(todo_list)

      expect(saver.todo_list).to eq todo_list
    end
  end
end
