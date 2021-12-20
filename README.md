# README

I haven't tested yet if this works for someone cloning the repo and testing locally. I think whoever clones this repo would need to replace the Stripe test secret key in the Rails credentials with their own test key (otherwise we'd have to share). Also, for your Stripe CLI authentication, when you run `strip listen --forward-to localhost:3000/webhooks` you may get a new webhook key, which also needs to be updated in Rails credentials.

After cloning the repo, you should be able to `rails db:setup`, then start the rails server `rails s` and navigate to localhost:3000.

Walkthrough: https://www.youtube.com/watch?v=JN7ZYhO9-es
