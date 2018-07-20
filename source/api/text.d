module tym.textAPI;
import std.algorithm.searching;
import std.array;
import tym.data;
import deDE = tym.i8n.deDE;
import enEN = tym.i8n.enEN;
import tym.motd;
import tm = tym.textmodel;
import vibe.web.rest;
import vibe.d;

/**
*	Handles translation of text.
*/
@path("/api/i8n")
interface ITextAPI {
	/**
	*	Gets the language specific dictionary for rendering.
	*/
	@headerParam("lang","Accept-Language")
	@path("lib")
	tm.Text getText(string lang);

	/**
	*	Deprecated: This was just for testing.
	*/
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
