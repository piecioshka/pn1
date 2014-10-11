sbit at 0xB4 T1;
xdata at 0x8000 unsigned char U12;

void main(void)
{
  unsigned char i, r = 0;
  unsigned char w = 0;
  
  for(;;)
  {
        if ((U12 & 0x0F) == 0x0E)
        {
                w = 1;
            }
        else if ((U12 & 0x0F) == 0x0D)
        {
                w = 0;
            }
        else if ((U12 & 0x0F) == 0x0B)
        {
                w = 2;
            }
        else if ((U12 & 0x0F) == 0x07)
        {
                w = 3;
            }
    
    if (w == 1)
    {
                if((r & 0x01) == 0)
                    T1 = 1;
                else
                    T1 = 0;
                r++;
                for(i = 0; i < 130; i++);
            }
        else if (w == 2)
        {
                    if((r & 0x01) == 0)
                    T1 = 1;
                else
                    T1 = 0;
                r++;
                for(i = 0; i < 70; i++);
                
                }
        else if (w == 3)
        {
                    if((r & 0x01) == 0)
                    T1 = 1;
                else
                    T1 = 0;
                r++;
                for(i = 0; i < 300; i++);
                
                }
    }
}
