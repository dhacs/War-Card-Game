defmodule War do

	def wartest() do
		IO.inspect(deal([1,2,3,4]))
	end


  def deal(shuf) do
    deal(shuf, [], []) #calls shuffle with player 1 and player2 decks
  end

  defp deal([x, y], player1, player2) do
		#base case check - card dealing is done, calls gametime to start the game with the two decks
		gametime([x] ++ player1 ,[y] ++ player2 )
	 end

	 defp deal(shuf, player1, player2) do
		 deal(tl(tl(shuf)), [hd(shuf)] ++ player1, [hd(tl(shuf))] ++ player2) #recursively deals cards from the bottom up
	 end

	defp gametime(player1, player2) do

    cond do
      length(player1) == 0 -> player2 #returns winners if other list is empty
      length(player2) == 0 -> player1
			hd(player1) == hd(player2) -> war(tl(player1), tl(player2), [hd(player1)] ++ [hd(player2)])
      #calls war if cards are even , takes two cards and puts into the war chest

			#if cards are 1 (the highest value) it counts as a win
			hd(player1) == 1 and hd(player2) != 1 -> gametime(tl(player1) ++ [hd(player1)] ++ [hd(player2)], tl(player2))
      hd(player2) == 1 and hd(player1) != 1 -> gametime(tl(player1), tl(player2) ++ [hd(player2)] ++ [hd(player1)])

			#if card is higher than the other, calls gametime with the loser's deck subtracted and winner's added
      hd(player1) > hd(player2) -> gametime(tl(player1) ++ [hd(player1)] ++ [hd(player2)], tl(player2))
      hd(player2) > hd(player1) -> gametime(tl(player1), tl(player2) ++ [hd(player2)] ++ [hd(player1)])
      #recursive calls to continue function
    end
	end

	#checks if a player runs out of cards during the war, gives existing sorted pile to winner and returns winner
	defp war([],player2,pile) do
		player2 ++ modisort(pile)
	end
	defp war(player1,[],pile) do
		player1 ++ modisort(pile)
	end

	#players with 1 card remaining cannot play war as war needs two cards.
  #adds sorted pile and remaining card to winner and returns
	defp war([x],player2, pile) do
		tl(player2) ++ modisort(pile ++ [x] ++ [hd(player2)])
	end
	defp war(player1, [x], pile) do
		tl(player1) ++ modisort(pile ++ [x] ++ [hd(player1)])
	end

	#note: war pile initially contains the first2 cards that started the war, and player decks initially have the card removed
	#draw two cards each, if first card is equal, all 4 go into the chest, 2 new cards are drawn
	defp war(player1, player2, pile) do
		down1 = hd(player1)
		down2 = hd(player2)
		up1 = hd(tl(player1))
		up2 = hd(tl(player2))
		#up and down are first two cards from the players

		player1 = tl(tl(player1))
		player2 = tl(tl(player2))
		pile = modisort(pile ++ [up1] ++ [up2] ++ [down1] ++ [down2])
		#updates both players hands, removes the cards and adds them to the pile
		cond do
      #check for 1's
			up1 == 1 and up2 != 1 -> gametime(player1 ++ pile, player2)
			up2 == 1 and up1 != 1 -> gametime(player1, player2 ++ pile)

      #normal war check
			up1 > up2 -> gametime(player1 ++ pile, player2)
			up2 > up1 -> gametime(player1, player2 ++ pile)
			up1 == up2 -> war(player1, player2, pile)
			#tie, 4 cards go into war pile, 2 cards taken from players and restarts
		end
	end

	#modified sort with 1 being the biggest number
	def modisort(list) do
		Enum.reverse(Enum.filter(Enum.sort(list), fn x -> x != 1 end) ++ Enum.filter(Enum.sort(list), fn x -> x == 1 end))
		 #returns the sorted list with ones at the bottom, using filter to remove them initially and add them to beginning of sorted list
     #note: after doing this, i realized i could just change the 1's to 14's and back... oops
  end



end
