module tym.api.text;
import std.algorithm.searching;
import std.array;
import deDE = tym.core.i8n.deDE;
import enEN = tym.core.i8n.enEN;
import tm = tym.core.i8n.textModel;
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
}
