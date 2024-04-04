#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
#Using While Loop And Adding tables :

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNERG OPPONENTG
do
  if [[ $WINNER != "winner" ]]
  then
    #TEAMS TABLE INSERTION :"
    TEAM_ID_W=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    TEAM_ID_O=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    if [[ -z $TEAM_ID_W ]]
    then
      INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      echo "INSERTED TEAM -> $WINNER"
    fi

    if [[ -z $TEAM_ID_O ]]
    then
      INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      echo "INSERTED TEAM -> $OPPONENT"
    fi

    #GAMES TABLE INSERTION:
    
      WIN_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
      OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

      INSERT_GAME_DATA=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES('$YEAR','$ROUND','$WIN_ID','$OPP_ID','$WINNERG','$OPPONENTG')")

      echo "GAME INSERTED $WIN_ID -> $OPP_ID"
   
  fi
done