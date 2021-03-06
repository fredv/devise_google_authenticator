module DeviseGoogleAuthenticator
  module Controllers # :nodoc:
    module Helpers # :nodoc:
      def google_authenticator_qrcode(user, qualifier=nil)
        username = username_from_email(user.email)
        app = user.class.ga_app_name || Rails.application.class.parent_name
        issuer = user.class.ga_issuer 
        data = "otpauth://totp/#{otpauth_user(username, app, qualifier)}?secret=#{user.gauth_secret}&issuer=#{issuer}"
        data = Rack::Utils.escape(data)
        url = "https://chart.googleapis.com/chart?chs=200x200&chld=M|0&cht=qr&chl=#{data}"
        return image_tag(url, :alt => 'Google Authenticator QRCode')
      end
      
      def otpauth_user(username, app, qualifier=nil)
        "#{username}@#{app}#{qualifier}"
      end 

      def username_from_email(email)
        (/^(.*)@/).match(email)[1]
      end
      
    end
  end
end
