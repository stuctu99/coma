package com.coma.approval.pdf;

import java.io.IOException;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactoryImp;
import com.itextpdf.text.pdf.BaseFont;


//테스트용 클래스 ! 안씀....
public class DefaultFontProvider extends FontFactoryImp{

	private String _default;
	
	public DefaultFontProvider(String def) {
		_default = def;
	}
	
	public Font getFont(String fontname, String encoding, boolean embedded, float size, 
						int style, BaseColor color) {
		try {
			//한글 깨짐 방지를 위한 폰트 세팅
			return new Font(BaseFont.createFont(_default, BaseFont.IDENTITY_H, BaseFont.EMBEDDED),
							9, style, BaseColor.BLACK);
		}catch(DocumentException e) {
			e.printStackTrace();
		}catch(IOException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	
}
