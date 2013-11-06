c Sets up table = dexptablesmall, values of NEGATIVE exponentials,
c Arguments 0.000 to 5.000 in .001 steps.

         SUBROUTINE dexptablesmall_setup (dexptablesmall)
        
         real*8 dexptablesmall(0:5000), z
         integer i

         do i = 0, 5000
           z = dble(i)
           z = - 0.001 * z
           dexptablesmall(i) = dexp (z)
         end do
         END 
