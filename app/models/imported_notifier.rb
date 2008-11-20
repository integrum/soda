class ImportedNotifier < ActionMailer::Base
  
   def gocrazy(name,email,username,password)
     recipients "\"#{name}\" <#{email}>"
     from       "news@asusoda.com"
     subject    "[SoDA] Website & Mailing List Migration: Username & Password"
     body       "Dear #{name}, \n\nAs a subscriber on the ASU SoDA email list, you have " +
     	"been automatically migrated to our new website and email system.\n\n" +
     	"Your username is #{username} and your password is #{password}.  This is " +
     	"associated with your email account, #{email}. \n\n" +
     	"You may unsubscribe from emails from us at any time by editing " +
     	"your account after logging in to the website <http://asusoda.com>, or in " +
     	"future emails, using a link at the bottom. \n\n" +
     	"If you have any questions or concerns, please send an email to " +
     	"news@asusoda.com.\n\nThank you.\n\nAlan Hogan\n" +
     	"President, Software Developers Association at ASU"
     headers	'return-path' => 'bounces@asusoda.com'
   end
end

# TODO: Talk about gravatars, privacy, skill list, résumé, personal URL, changing Password
