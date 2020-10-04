
#BeginMacro(Self)
   (0,0)
#EndMacro

#BeginMacro(North)
   (-1,0)
#EndMacro

#BeginMacro(South)
   (1,0)
#EndMacro

#BeginMacro(East)
   (0,1)
#EndMacro

#BeginMacro(West)
   (0,-1)
#EndMacro


#BeginMacro(MAX_C_Neighbour)
max( max( max( max( (-1,0),(1,0) ),(0,1) ),(0,-1) ),(0,0) )
#EndMacro

#BeginMacro(MAX_O_Neighbour)
max( max( max( (-1,0),(1,0) ),(0,1) ),(0,-1) )
#EndMacro