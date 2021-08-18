Check CritRole shop

- `cd` into repo
- `bundle install`
- `ruby check_shop.rb`

By default it will check the URL "https://canada.critrole.com/collections/all-products/products/baileys-dice-bag-of-hoarding?variant=36226702999718"

If you pass a url on the command line it will check the availability of other products. Example

- `ruby check_shop.rb https://canada.critrole.com/collections/all-products/products/vox-machina-dice-set-gm`

It will either output "Product in Stock" with the url to get right to the store (if you use iTerm2, you can just Cmd-Click the url and it will open in your default browser)
or
"Product out of Stock" if it's unavailable
