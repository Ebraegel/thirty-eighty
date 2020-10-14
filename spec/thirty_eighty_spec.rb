require 'spec_helper'

describe 'checking availability after a paper launch', type: :feature, js: true do
  describe 'on newegg.com' do
    url = config['newegg']['search_url']
    it "searching for 3000 series at #{url}" do
      visit url
      items = all('.item-cell')
      expect(items).to all(have_text 'OUT OF STOCK')
    end
  end

  describe 'on bestbuy.com' do
    url = config['best_buy']['search_url']
    it "searching for 3000 series at #{url}" do
      visit url
      expect(page).not_to have_text('Add to Cart')
    end
  end

  describe 'on bhphotovideo.com' do
    url = config['bh']['search_url']
    it "searching for 3000 series at #{url}" do
      visit url
      button_texts = all('div[data-selenium="miniProductPageQuantityContainer"] > div > button').map(&:text)
      button_texts.each do |text|
        expect(text).to eq('Notify When Available')
      end
    end
  end

  describe 'on microcenter.com' do
    url = config['microcenter']['search_url']
    it "searching for 3000 series at #{url}" do
      visit url
      my_store = page.find('#siteSelections > ul.myStore.inline > li.loc.store.clear > strong').text
      expect(my_store).to eq(config['microcenter']['store_name'])
      stock_info = page.all('.stock').map(&:text)
      expect(stock_info.uniq).to eq(['SOLD OUT'])
    end
  end

  describe 'on nvidia.com' do
    url = config['nvidia']['search_url']
    it "searching for 3000 series at #{url}" do
      visit url
      button_texts = page.all('.link-btn').map(&:text)
      button_texts.each do |text|
        expect(text).to eq('NOTIFY ME').or(eq('OUT OF STOCK'))
      end
    end
  end
end





