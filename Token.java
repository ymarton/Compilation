import java_cup.runtime.Symbol;

public class Token extends Symbol {
	
	private int line, column;
	private String tag, value;
	
	public Token(int id){
		super(id,null);
	}

	public Token(int id, int line) {
		super(id, null);
		this.line = line;
		this.tag = id + "";
	}

	public Token(int id, int line, int column, String tag, String value) {
		super(id, null);
		this.line = line;
		this.column = column;
		this.tag = tag;
		this.value = value;
	}
	
	public int getLine() {
		return line;
	}
	
	public int getColumn() {
		return column;
	}
	
	public String getTag() {
		return tag;
	}
	
	public String getValue() {
		return value;
	}
}
