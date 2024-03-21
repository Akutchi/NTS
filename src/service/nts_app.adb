with Ada.Text_IO;   use Ada.Text_IO;
with GNAT.Sockets;  use GNAT.Sockets;

with Ada.Streams;
use type Ada.Streams.Stream_Element_Count;

package body Nts_App is

    function Check_End (Data : Unbounded_String;
                        First_CR_Passed : in out Boolean;
                        Offset_Before_EndCheck : in out Natural)

    return Boolean
    is
        Data_Str    : String := To_String (Data);
        Terminator  : String := (1 => ASCII.CR, 2 => ASCII.LF,
                                 3 => ASCII.CR, 4 => ASCII.LF);
    begin

        if not First_CR_Passed and Data_Str (Data_Str'Last) = ASCII.CR then
            Offset_Before_EndCheck := 3;
            First_CR_Passed := True;

        elsif Offset_Before_EndCheck > 0 then
            Offset_Before_EndCheck := Offset_Before_EndCheck - 1;

        elsif Offset_Before_EndCheck = 0 then
            if Data_Str (Data_Str'Last - 4 .. Data_Str'Last) = Terminator then
                return True;
            end if;
            First_CR_Passed := False;
        end if;

        return False;

    end Check_End;

    function nts return Any_nts
    is
        One_Nts : Any_nts := new nts_agregator;
    begin
        GNAT.Sockets.Initialize;
        Create_Socket (One_Nts.Server);
        Set_Socket_Option (One_Nts.Server,
                           Socket_Level,
                           (Reuse_Address, True));
        Set_Socket_Option (One_Nts.Server,
                           Socket_Level,
                           (Receive_Timeout, Timeout => 5.0));

        return One_Nts;
    end nts;

    procedure Listen (N : Any_nts; Port_Nb : Port_Type)
    is
        Offset_Before_EndCheck : Natural := 5;
        First_CR_Passed : Boolean := False;
    begin

        Bind_Socket (N.Server,  Address =>
                                (Family => Family_Inet,
                                Addr => Inet_Addr ("127.0.0.1"),
                                Port => Port_Nb));

        Listen_Socket (N.Server);
        Accept_Socket(N.Server, N.Socket, N.Address);
        N.Channel := Stream (N.Socket);

        loop
            loop

                declare
                    Read_Char : Character :=
                        Character'Val (N.Receive (N.Receive'First));
                begin

                    Ada.Streams.Read (N.Channel.All, N.Receive, N.Offset);
                    Append (N.Data, Read_Char);

                    exit when Check_End (N.Data,
                                         First_CR_Passed,
                                         Offset_Before_EndCheck);

                    Put (Read_Char);
                end;
            end loop;
            Put_Line (To_String (N.Data));
        end loop;

    end Listen;

end Nts_App;