func (s *DefaultStrategy) forwardAuthenticationRequest(w http.ResponseWriter, r *http.Request, ar fosite.AuthorizeRequester, subject string, authenticatedAt time.Time, session *LoginSession) error {
...
	// Set up csrf/challenge/verifier values
	verifier := strings.Replace(uuid.New(), "-", "", -1)
	challenge := strings.Replace(uuid.New(), "-", "", -1)
	csrf := strings.Replace(uuid.New(), "-", "", -1)


verifier = {string} "9d430796f2154a93b5db111ea822bf07"
challenge = {string} "39165a3b5af44627adb0e39cba59e94e"
csrf = {string} "2da2b414379d4859964d4d81f3a8dae8"

...

sessionID := uuid.New()
	if session != nil {
		sessionID = session.ID
	} else {
		// Create a stub session so that we can later update it.
		if err := s.r.ConsentManager().CreateLoginSession(r.Context(), &LoginSession{ID: sessionID}); err != nil {
			return err
		}
	}