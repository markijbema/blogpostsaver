### Not shown in blog post
require 'rspec/autorun'

class TodoItem
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
    pending "it returns a todo_list"
  end
end
