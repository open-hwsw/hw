`timescale 1ns/1ps

module tb;
  
    logic mclk      ;
    logic burst_mode;
    logic trdy      ;
    logic irdy      ;

    initial begin
        forever begin
  		    mclk = 0;
      	    #1;
    	    mclk = 1;
      	    #1;
        end
    end
  
    initial begin

        burst_mode = 1;
        trdy = 1;
        irdy = 1;
    
        fork
            begin
                repeat(1)begin
                    @(negedge mclk);
                end
                burst_mode = 0;
                repeat(7)begin
                    @(negedge mclk);
                end
                burst_mode = 1;
            end

            begin
                repeat(2)begin
                    @(negedge mclk);
                end
                irdy = 0;
                repeat(9)begin
                    @(negedge mclk);
                end
                irdy = 1;
            end

            begin
                repeat(3)begin
                    @(negedge mclk);
                end
                trdy = 0;
                repeat(7)begin
                    @(negedge mclk);
                end
                trdy = 1;
            end
      
        join

        repeat(10)begin
            @(posedge mclk);
        end

        fork
            begin
                repeat(1)begin
                    @(negedge mclk);
                end
                burst_mode = 0;
                repeat(10)begin
                    @(negedge mclk);
                end
                burst_mode = 1;
            end

            begin
                repeat(2)begin
                    @(negedge mclk);
                end
                irdy = 0;
                repeat(9)begin
                    @(negedge mclk);
                end
                irdy = 1;
            end

            begin
                repeat(3)begin
                    @(negedge mclk);
                end
                trdy = 0;
                repeat(7)begin
                    @(negedge mclk);
                end
                trdy = 1;
            end
      
        join

        repeat(10)begin
            @(posedge mclk);
        end
        
        $finish(2);

    end
      
    property burst_rule1;
        @(posedge mclk)
  	        $fell(burst_mode) ##0 ((!burst_mode) throughout (##2 ((trdy == 0)&&(irdy==0)) [7]));
    endproperty  burst_rule1
  
    assert property(burst_rule1);

endmodule  tb

