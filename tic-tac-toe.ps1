function Start-TheGame {

function Get-Move($Player) {

$PlayerInput = Read-Host "$Player's turn: Give your coordinates. 22 is the middle"

$Coords = @{

RowMove = [int][string]$PlayerInput[0]

ColumnMove = [int][string]$PlayerInput[1] - 1

}


return $Coords

}


function Get-HasPlayerWon($Player) {

function Get-ThreeInARow($Content) {

return ($content.where({$_ -eq $Player}).count -eq 3)

}


switch ($PlayingField) {

{Get-ThreeInARow @($_[1][0], $_[2][1],$_[3][2])} {return $True} #Diagonal win upper-left corner

{Get-ThreeInARow @($_[1][2], $_[2][1],$_[3][0])} {return $True} #diagonal win lower-left corner

{($_[1..3] | % {Get-ThreeInARow $_}) -contains $true} {return $true} #Row wins

{(0..2 | % {$i = $_; get-threeinarow ($playingfield[1..3] | % {$_[$i]})}) -contains $true} {return $true} #Column wins

}


return $false

}


$PlayingField = @{

1 = ".", ".", "."

2 = ".", ".", "."

3 = ".", ".", "."

}


$XsMove = $True

while ($true) {

if ($XsMove) {

$Move = get-Move X

if ($PlayingField[$Move.RowMove][$Move.ColumnMove] -eq ".") {

$PlayingField[$Move.RowMove][$Move.ColumnMove] = "X"

}


else {

"You can only move on a empty square"

continue

}


if (Get-HasPlayerWon X) {

return "X has won! Yay!"

}


$PlayingField.GetEnumerator() | sort name | % {write-host $_.value}

$XsMove = $false

}


elseif (-not $XsMove) {

$Move = get-Move O

if ($PlayingField[$Move.RowMove][$Move.ColumnMove] -eq ".") {

$PlayingField[$Move.RowMove][$Move.ColumnMove] = "O"

}


else {

"You can only move on a empty square"

continue

}

if (Get-HasPlayerWon O) {

return "O has won. Let's go!"

}


$PlayingField.GetEnumerator() | sort name | % {write-host $_.value}

$XsMove = $True

}

}

}


while ((Read-Host "Do you want to start the game (again)? y/n") -eq "y"){

Start-TheGame

}
