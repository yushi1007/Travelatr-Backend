class ApplicationController < ActionController::API
    def authenticate
        # TODO: check some identifying info about request (token header)
        # if user is logged in
        # the can access this route
        # otherwise
        # don't give them access
        # @current_user = User.first
        auth_header = request.headers["Authorization"]
        token = auth_header.split.last
        payload = JWT.decode(token, 'my_secret', true, { algorithm: 'HS256' })[0]
        @current_user = User.find_by(id: payload["user_id"])
        #Error handling
    rescue
        render json: { errors: ["Not Authorized"] }, status: :unauthorized
    end
end
