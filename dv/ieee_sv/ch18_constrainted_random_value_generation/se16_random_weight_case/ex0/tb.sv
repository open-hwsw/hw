module automatic tb;
    
    byte x;
    int hit [byte];
    
    initial begin

        repeat(3+1+4)begin
            randcase
                3 : x = 1;
                1 : x = 2;
                4 : x = 3;
            endcase
            hit[x]++;        
        end

        $display("the expected probability of taking the first branch = %f, and actual probability = %f", real'(3) / real'(3+1+4), real'(hit[1]) /  real'(3+1+4) );
        $display("the expected probability of taking the second branch = %f, and actual probability = %f", real'(1) / real'(3+1+4), real'(hit[2]) / real'(3+1+4) );
        $display("the expected probability of taking the third branch = %f and actual probability = %f", real'(4) / real'(3+1+4),  real'(hit[3]) / real'(3+1+4) );

    end

endmodule : tb