class HTTPStatusCodes
  extend OSNinja::Scriptlet

  description "Print HTTP status codes"
  tags  :net, :http

  def self.run
    puts """
    1xx Informational
      100: Continue (:continue)
      101: Switching Protocols (:switching_protocols)
      102: Processing (:processing)
    
    2xx Success
      200: OK (:ok)
      201: Created (:created)
      202: Accepted (:accepted)
      203: Non-Authoritative Information (:non_authoritative_information)
      204: No Content (:no_content)
      205: Reset Content (:reset_content)
      206: Partial Content (:partial_content)
      207: Multi-Status (:multi_status)
      226: IM Used (:im_used)
    
    3xx Redirection
      300: Multiple Choices (:multiple_choices)
      301: Moved Permanently (:moved_permanently)
      302: Moved Temporarily (HTTP/1.0)
      302: Found (HTTP/1.1) (:found)
      303: See Other (HTTP/1.1) (:see_other)
      304: Not Modified (:not_modified)
      305: Use Proxy (:use_proxy)
      306: (no longer used, but reserved)
      307: Temporary Redirect (:temporary_redirect)
    
    4xx Client Error
      400: Bad Request (:bad_request)
      401: Unauthorized (:unauthorized)
      402: Payment Required (:payment_required)
      403: Forbidden (:forbidden)
      404: Not Found (:not_found)
      405: Method Not Allowed (:method_not_allowed)
      406: Not Acceptable (:not_acceptable)
      407: Proxy Authentication Required (:proxy_authentication_required)
      408: Request Timeout (:request_timeout)
      409: Conflict (:conflict)
      410: Gone (:gone)
      411: Length Required (:length_required)
      412: Precondition Failed (:precondition_failed)
      413: Request Entity Too Large (:request_entity_too_large)
      414: Request-URI Too Long (:request_uri_too_long)
      415: Unsupported Media Type (:unsupported_media_type)
      416: Requested Range Not Satisfiable (:requested_range_not_satisfiable)
      417: Expectation Failed (:expectation_failed)
      422: Unprocessable Entity (:unprocessable_entity)
      423: Locked (:locked)
      424: Failed Dependency (:failed_dependency)
      426: Upgrade Required (:upgrade_required)
    
    5xx Server Error
      500: Internal Server Error (:internal_server_error)
      501: Not Implemented (:not_implemented)
      502: Bad Gateway (:bad_gateway)
      503: Service Unavailable (:service_unavailable)
      504: Gateway Timeout (:gateway_timeout)
      505: HTTP Version Not Supported (:http_version_not_supported)
      507: Insufficient Storage (:insufficient_storage)
      510: Not Extended (:not_extended)
  """
  end

end
