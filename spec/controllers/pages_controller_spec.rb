require 'spec_helper'

describe PagesController do
	
	it 'should render textile-ized content of the file into the app layout' do
		
		textoOriginal = 'um texto qualquer'
		textoProcessado = 'o texto depois de ter sido processado'
		
		path = File.expand_path(File.join(File.dirname(__FILE__), '../../public/pages/o_que_eh_coding_dojo.textile'))
		
		file = mock('file')
		File.should_receive(:new).with(path).and_return(file)
		file.should_receive(:read).with(nil).and_return(textoOriginal)
		
		redcloth = mock('redcloth')
		RedCloth.should_receive(:new).with(textoOriginal).and_return(redcloth)
		redcloth.should_receive(:to_html).and_return(textoProcessado)
		
		get :show, :id=>'o_que_eh_coding_dojo'
		
		assigns[:page].should == textoProcessado
		response.should render_template('show')
		
	end
	
	
end