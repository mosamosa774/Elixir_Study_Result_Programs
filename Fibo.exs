# This program is to compute the fibonacci number in Elixir Language 
defmodule Fibo do
def get_fibo_number(n,memo) when n == 0 do
        [0,Map.put(memo,n,0)]
end
def get_fibo_number(n,memo) when n <= 2 do
        [1,Map.put(memo,n,1)]
end
def get_fibo_number(n,memo) do
        [x1,memo] = if memo[n-1] do
                [Map.get(memo,n-1),memo]
        else
                get_fibo_number(n-1,memo)
        end
        [x2,memo] = if memo[n-2] do
                [Map.get(memo,n-2),memo]
        else
                get_fibo_number(n-2,memo)
        end
        res = x1+x2
        [res,Map.put(memo,n,res)]
end
end

[res,_] = Fibo.get_fibo_number(100,%{})
IO.puts res
