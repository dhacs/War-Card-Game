#![allow(non_snake_case,non_camel_case_types,dead_code)]

fn deal(shuf: &[u8; 52]) -> [u8; 52]
{
    let pogshuffle = gametime(shuffle(shuf)); // calls gametime and shuffle 
    return winner(&pogshuffle); //returns the winning vec as an array
}
fn shuffle(shuf: &[u8; 52]) -> (Vec<u8>, Vec<u8>) { //creates 2 mutable vecs for both hands 
    let mut player1: Vec<u8> = Vec::new();
    let mut player2: Vec<u8> = Vec::new();
    //REPLACES 1's with 14's so thye can be properly ordered
    if shuf[0] == 1 { 
        player1.push(14);
    }else{
        player1.push(shuf[0]);
    }
    //loop to add to both decks 
    for x in 1..(shuf.len()){
        if x % 2 == 0{
            if shuf[x] == 1 {
                player1.insert(0,14);
            }
            else{
                player1.insert(0,shuf[x]); //adds to TOP of deck
            }
        }else{
            if shuf[x] == 1 {
                player2.insert(0,14);
            }
            else{
                player2.insert(0,shuf[x]); //adds to TOP of deck
            }
        }
    }
    return (player1, player2); //return a tuple of two vecs 
}

fn gametime(players: (Vec<u8>, Vec<u8>)) -> Vec<u8> {
    let mut player1 = players.0;
    let mut player2 = players.1;
    
    while player1.len() != 0 && player2.len() != 0 {  
        let card1 = player1.remove(0);
        let card2 = player2.remove(0);
        //normal checks for greater cards
        if card1 > card2 {
            player1.push(card1);
            player1.push(card2);
        }
        else if card2 > card1 {
            player2.push(card2);
            player2.push(card1);
        }
        else{ //equal so calls war 
            let mut warchest = vec![card1, card2]; //og warchest with both cards 
            //initial check before i call the war (no recursive calls)
            if player1.len() == 0{ // player2 wins, no more cards 
                player2.extend(warchest.clone());
                return player2;
            }
            else if  player2.len() == 0{ //player1 wins , no more cards
                player1.extend(warchest.clone());
                return player1;
            }
            if player1.len() == 1{ // player2 wins, 1 card left, adds leftover cards to the warchest, sorts and adds to player2
                let add = player2.remove(0);
                warchest.extend(player1);
                warchest.push(add);
                warchest.sort();
                warchest.reverse();
                player2.extend(warchest.clone());
                return player2;
            }
            else if  player2.len() == 1{ //player1 wins , 1 card left, adds leftover cards to the warchest, sorts and adds to player1
                let add = player1.remove(0);
                warchest.extend(player2);
                warchest.push(add);
                warchest.sort();
                warchest.reverse();
                player1.extend(warchest.clone());
                return player1;
            }
            //warcheck starts
            'outer: while player1.len() > 1 && player2.len() > 1 {
                //initializes the face down and face up cards
                let down1 = player1.remove(0);
                let down2 = player2.remove(0);
                let up1 = player1.remove(0);
                let up2 = player2.remove(0);
                warchest.extend(&[down1, down2, up1, up2]); // adds the face up and down cards to the warchest 
                warchest.sort();
                warchest.reverse(); //warchest sorted in descending order
                if up1 > up2{ //player1 wins war
                    player1.extend(warchest.clone());
                    break 'outer; //leaves the war loop
                }
                else if up2 > up1{ //player2 wins war
                    player2.extend(warchest.clone());
                    break 'outer;
                //check for no cards
                }else if player1.len() == 0{ // player2 wins
                    player2.extend(warchest.clone());
                    return player2;
                }
                else if  player2.len() == 0{ //player1 wins
                    player1.extend(warchest.clone());
                    return player1;
                }
                //check for 1 card left
                if player1.len() == 1{ // player2 wins
                    warchest.extend(player1);
                    warchest.sort();
                    warchest.reverse();
                    player2.extend(warchest.clone());
                    return player2;
                }
                else if  player2.len() == 1{ //player1 wins
                    warchest.extend(player2);
                    warchest.sort();
                    warchest.reverse();
                    player1.extend(warchest.clone());
                    return player1;
                }
            }
        }
    }
    //non0-war check to  find winners
    if player1.len() == 0{
        return player2;
    }
    else{
        return player1;
    }
}
fn winner(win: &Vec<u8>) -> [u8; 52] { //converts the vec back to an array for returning, changes the 14's back to 1s 
    let mut array: [u8; 52] = [0; 52];
    for x in 0..52 {
        if win[x] == 14{
            array[x] = 1;
        }else{
            array[x] = win[x];
        }
    }
    return array;
}
#[cfg(test)]
#[path = "tests.rs"]
mod tests;