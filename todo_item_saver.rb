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
    context 'the list to save it to exists' do
      it 'creates the todo and adds it to a list' do
        todo_list, todo = mock, mock
        saver = TodoSaver.new('WriTing', 'write blogpost')
        TodoList.stub(:retrieve).with('writing').and_return(todo_list)

        TodoItem.should_receive(:create).with('write blogpost')
                .and_return(todo)
        todo_list.should_receive(:add).with(todo)

        saver.save()
      end
    end
    context 'the list to save it does not exist' do
      it 'creates the todo and adds it to a newly created list' do
        todo_list, todo = mock, mock
        saver = TodoSaver.new('WriTing', 'write blogpost')
        saver.stub todo_list: todo_list
        TodoList.stub(:retrieve).with('writing').and_return(nil)
        TodoList.stub(:create).with('WriTing').and_return(todo_list)

        TodoItem.should_receive(:create).with('write blogpost')
                .and_return(todo)
        todo_list.should_receive(:add).with(todo)

        saver.save()
      end
    end
  end
end
