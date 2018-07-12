module tym.textAPI;
import std.algorithm.searching;
import std.array;
import tm = tym.textmodel;
import enEN = tym.i8n.enEN;
import deDE = tym.i8n.deDE;
import vibe.web.rest;
import tym.data;
import vibe.d;

@path("/api/i8n")
interface ITextAPI {
	@headerParam("lang","Accept-Language")
	@path("lib")
	tm.Text getText(string lang);

	@path("motd")
	string getMOTD();
}

class TextAPI : ITextAPI {
   tm.Text getText(string lang){
		string[] langs = split(lang,",");
		for(int i; i < langs.length; i++){
			if(canFind(langs[i], "de")){
				return deDE.getText();
			}
			if(canFind(langs[i], "en")) {
				return enEN.getText();
			}
		}
		return enEN.getText();
	}
	string getMOTD() {
		MOTD motd = new MOTD();
		motd.text.setValue("This is a MOTD!");
		return motd.text.getValue();
	}
}
class MOTD : ITable {
	string Schema() { return "dbo"; }
	string Name() { return "motd"; }
	Column ID = new Column("ID", new DbInt16(true));
	Column text = new Column("ID", new DbChar(100));
	IColumn[] Columns() { return [ ID, text ]; }
}
