package com.fkiller.web.contants;

public enum Colors {
	RED("#DC4343"), YELLOW("#EFDE47"), BLUE("#5F8EEC"), MAGENTA("#EF72D3"), GREEN("#49B327"), 
	SKYBLUE("#4FC7D4"), PUPLE("#9E68EA"), ORANGE("#F7A63F"), LIGHTGREEN("#97D02C"), PINK("#F18D8D");//#5CC33B
	
	private String colorCode;
	
	Colors(String colorCode){
		this.colorCode=colorCode;
	}
	
	public String value(){
		return this.colorCode;
	}
}

