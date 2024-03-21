with GNAT.Sockets;  use GNAT.Sockets;

with Ada.Streams;
use type Ada.Streams.Stream_Element_Count;

package Nts_App is

    type nts_agregator is private;
    type Any_nts is access all nts_agregator;

    function nts return Any_nts;

    procedure Listen (N : Any_nts; Port_Nb : Port_Type);


private

    type nts_agregator is record

        Server : Socket_Type;
        Socket : Socket_Type;
        Address: Sock_Addr_Type;
        Channel: Stream_Access;

        Offset : Ada.Streams.Stream_Element_Count;
        Data   : Ada.Streams.Stream_Element_Array (1 .. 1);

    end record;

end Nts_App;