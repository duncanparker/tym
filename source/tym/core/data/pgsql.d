module tym.core.data.pgsql;
import tym.settings;
import vibe.core.net;
import std.conv;

enum MessageType: char {
	PGBIND					= 'B',
	PGCLOSE					= 'C',
	PGDESCRIBE			= 'D',
	PGEXECUTE				= 'E',
	PGFUNCTIONCALL	= 'F',
	PGFLUSH					= 'H',
	PGPARSE					= 'P',
	PGSIMPLEQUERY		= 'Q',
	PGSYNC					= 'S',
	PGTERMINATE			= 'X',
	PGCOPYDATA			= 'd',
	PGCOPYDONE			= 'c',
	PGCOPYFAIL			= 'f',
	PGPASSWORDMSG		= 'p'
}

enum ResponseType: char {
	PGPARSECOMPLETE					= '1',
	PGBINDCOMPLETE					= '2',
	PGCLOSECOMPLETE					= '3',
	PGNOTIFICATIONRESPONSE	= 'A',
	PGCOMMANDCOMPLETE				= 'C',
	PGDATAROW								= 'D',
	PGERRORRESPONSE					= 'E',
	PGCOPYINRESPONSE				= 'G',
	PGCOPYOUTRESPONSE				= 'H',
	PGEMPTYQUERYRESPONSE		= 'I',
	PGBATCHENDKEYDATA				= 'K',
	PGNOTICERESPONSE				= 'N',
	PGAUTHENTICATION				= 'R',
	PGPARAMETERSTATUS				= 'S',
	PGROWDESCRIPTION				= 'T',
	PGFUNCTIONCALLRESPONSE	= 'V',
	PGCOPYBOTHRESPONSE			= 'W',
	PGREADYFORQUERY					= 'Z',
	PGPARAMETERDESCRIPTION	= 't',
	PGPORTALSUSPENDED				= 's',
	PGNODATA								= 'n',
	PGCOPYDATA							= 'd',
	PGCOPYDONE							= 'c'
}

enum ReadyState: char {
	PGERROR 			= 'E',
	PGIDLE 				= 'I',
	PGTRANSACTION	= 'T'
}

class PGConnection {

	private TCPConnection conn;

	public void open(){
		Settings s;
		conn = connectTCP(s.host, to!ushort(s.port));
		conn.keepAlive = true;
	}

	public void close(){
		conn.close();
	}
}
