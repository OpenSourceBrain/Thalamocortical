c Sets up table = dexptablebig, values of NEGATIVE exponentials,
c Arguments 0.00 to 1000.00 in .01 steps.

         SUBROUTINE dexptablebig_setup (dexptablebig)
        
         real*8 dexptablebig(0:10000), z
         integer i

         do i = 0, 10000
           z = dble(i)
           z = - 0.1 * z
           dexptablebig(i) = dexp (z)
         end do
         END 
