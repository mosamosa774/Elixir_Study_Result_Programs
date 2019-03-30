# This program is to greet to the child process via the spawned tasks in elixir language.
defmodule SpawnPerson do
  def call(n) when n > 1 do
    pids = call(n-1)
    {:ok, pid} = Task.start_link(fn -> loop(%{}) end)
    [pid] ++ pids
  end
  def call(n) do
    {:ok, pid} = Task.start_link(fn -> loop(%{}) end)
    [pid]
    end
  defp loop(map) do
    receive do
      {:greet, key, caller} ->
        case key do
           "Hello" ->
                send caller, {:res, "Hello", self()}
           "Good morning" ->
                send caller, {:res, "Good morning", self()}
           "Good evening" ->
                send caller, {:res, "Good evening", self()}
           _ ->
                send caller, {:res, "Hi", self()}
        end
        loop(map)
    end
  end
end

defmodule Parent do
   def speak(msg,pids) when msg != "exit" do
      IO.inspect pids, label: "Callable Persons"
      index = IO.gets "Greet to whose one? (Selecting by the number from zero) "
      [index,_] = String.split(index,"\n")
      index = String.to_integer(index)
      pid = Enum.at(pids,index)
      greet = IO.gets "What is greeting message? "
      [greet,_] = String.split(greet,"\n")
      send pid, {:greet, greet, self()}
      receive do
        {:res, res, child} ->
           IO.inspect child, label: "Response " <> res
      end
      IO.puts "\n next \n"
      speak(greet,pids)
   end
end

n = IO.gets "How many persons are exist? "
[n,_] = String.split(n,"\n")
n = String.to_integer(n)

pids = SpawnPerson.call(n)
Parent.speak("",pids)
