# User Story Template

## Historias de usuario administrador
### User Story

**Title:**  
_As an admin, I want to log into the portal with my username and password, so that I can manage the platform securely._

**Acceptance Criteria:**
1. The admin can access the login page.
2. The admin can enter a valid username and password.
3. The system grants access to the admin dashboard upon successful authentication.
4. The system displays an error message when invalid credentials are entered.

**Priority:** High  
**Story Points:** 3  

**Notes:**
- Passwords must be stored securely.
- Authentication should follow security best practices.

---

### User Story

**Title:**  
_As an admin, I want to log out of the portal, so that I can protect system access._

**Acceptance Criteria:**
1. The admin can log out from any authenticated page.
2. The system terminates the active session upon logout.
3. The admin is redirected to the login page after logging out.
4. Accessing protected pages after logout requires re-authentication.

**Priority:** High  
**Story Points:** 2  

**Notes:**
- Session tokens should be invalidated after logout.

---

### User Story

**Title:**  
_As an admin, I want to add doctors to the portal, so that I can maintain an up-to-date list of healthcare providers._

**Acceptance Criteria:**
1. The admin can access a form to add a new doctor.
2. The admin can enter the required doctor information.
3. The system validates mandatory fields before saving.
4. The new doctor profile is stored successfully and appears in the doctor list.

**Priority:** High  
**Story Points:** 5  

**Notes:**
- Required fields should include name, specialization, and contact information.
- Duplicate doctor records should be prevented.

---

### User Story

**Title:**  
_As an admin, I want to delete a doctor's profile from the portal, so that I can remove outdated or incorrect records._

**Acceptance Criteria:**
1. The admin can select a doctor profile for deletion.
2. The system asks for confirmation before deleting the profile.
3. The selected doctor profile is removed from the portal after confirmation.
4. The deleted profile no longer appears in the doctor list.

**Priority:** Medium  
**Story Points:** 3  

**Notes:**
- Only authorized admins can delete doctor profiles.
- Consider maintaining an audit log of deletions.

---

### User Story

**Title:**  
_As an admin, I want to run a stored procedure in MySQL CLI to get the number of appointments per month, so that I can track usage statistics._

**Acceptance Criteria:**
1. A stored procedure exists to calculate monthly appointment counts.
2. The admin can execute the stored procedure using MySQL CLI.
3. The procedure returns the number of appointments grouped by month.
4. The results are accurate based on the appointment data stored in the database.

**Priority:** Medium  
**Story Points:** 5  

**Notes:**
- The stored procedure should handle months with zero appointments.
- Results should be ordered chronologically.
- Appropriate database permissions are required to execute the procedure.

## Historias de usuario de pacientes
### User Story

**Title:**
_As a patient, I want to view a list of doctors without logging in, so that I can explore available options before registering._

**Acceptance Criteria:**
1. The system displays a list of available doctors to unauthenticated users.
2. The list includes basic doctor information such as name and specialty.
3. Patients can browse the list without creating an account.
4. The doctor list loads successfully on the public portal.

**Priority:** Medium  
**Story Points:** 3

**Notes:**
- Sensitive doctor information should not be displayed publicly.

---

### User Story

**Title:**
_As a patient, I want to sign up using my email and password, so that I can book appointments._

**Acceptance Criteria:**
1. The patient can access a registration form.
2. The patient can provide an email address and password.
3. The system validates the email format and required fields.
4. A new patient account is created successfully.
5. The patient can log in using the registered credentials.

**Priority:** High  
**Story Points:** 5

**Notes:**
- Email addresses must be unique.
- Passwords should be stored securely.

---

### User Story

**Title:**
_As a patient, I want to log into the portal, so that I can manage my bookings._

**Acceptance Criteria:**
1. The patient can access the login page.
2. The patient can enter valid credentials.
3. The system authenticates the patient successfully.
4. The patient is redirected to their dashboard after login.
5. An error message is displayed for invalid credentials.

**Priority:** High  
**Story Points:** 3

**Notes:**
- Authentication should follow security best practices.

---

### User Story

**Title:**
_As a patient, I want to log out of the portal, so that I can secure my account._

**Acceptance Criteria:**
1. The patient can access a logout option.
2. The system terminates the active session upon logout.
3. The patient is redirected to the login page.
4. Protected pages cannot be accessed without logging in again.

**Priority:** High  
**Story Points:** 2

**Notes:**
- Session tokens should be invalidated after logout.

---

### User Story

**Title:**
_As a patient, I want to log in and book an hour-long appointment with a doctor, so that I can receive medical consultation._

**Acceptance Criteria:**
1. The patient must be logged in to book an appointment.
2. The patient can select a doctor from the available list.
3. The patient can choose an available one-hour time slot.
4. The system confirms the appointment booking.
5. The booked appointment is saved in the system.

**Priority:** High  
**Story Points:** 8

**Notes:**
- Double booking should not be allowed.
- Only available time slots should be displayed.

---

### User Story

**Title:**
_As a patient, I want to view my upcoming appointments, so that I can prepare accordingly._

**Acceptance Criteria:**
1. The patient must be logged in to access appointment information.
2. The system displays all future appointments associated with the patient.
3. Each appointment shows the doctor, date, and time.
4. Appointments are displayed in chronological order.
5. Past appointments are not included in the upcoming appointments list.

**Priority:** Medium  
**Story Points:** 3

**Notes:**
- Appointment information should be updated in real time.

## Historias de usuarios médicos
### User Story

**Title:**
_As a doctor, I want to log into the portal, so that I can manage my appointments._

**Acceptance Criteria:**
1. The doctor can access the login page.
2. The doctor can enter valid credentials.
3. The system authenticates the doctor successfully.
4. The doctor is redirected to their dashboard after login.
5. An error message is displayed for invalid credentials.

**Priority:** High  
**Story Points:** 3

**Notes:**
- Authentication should follow security best practices.

---

### User Story

**Title:**
_As a doctor, I want to log out of the portal, so that I can protect my data._

**Acceptance Criteria:**
1. The doctor can access a logout option from any authenticated page.
2. The system terminates the active session upon logout.
3. The doctor is redirected to the login page.
4. Protected pages cannot be accessed without logging in again.

**Priority:** High  
**Story Points:** 2

**Notes:**
- Session tokens should be invalidated after logout.

---

### User Story

**Title:**
_As a doctor, I want to view my appointment calendar, so that I can stay organized._

**Acceptance Criteria:**
1. The doctor can access their appointment calendar after logging in.
2. The calendar displays all scheduled appointments.
3. Each appointment includes the date, time, and patient name.
4. Appointments are displayed in chronological order.
5. The calendar updates when appointments are added or modified.

**Priority:** High  
**Story Points:** 5

**Notes:**
- Calendar data should be refreshed in real time when possible.

---

### User Story

**Title:**
_As a doctor, I want to mark my unavailability, so that patients can only book available time slots._

**Acceptance Criteria:**
1. The doctor can select dates and times to mark as unavailable.
2. Unavailable periods are saved successfully.
3. Patients cannot book appointments during unavailable periods.
4. The doctor can view and manage their unavailable time slots.
5. The system updates appointment availability immediately.

**Priority:** High  
**Story Points:** 5

**Notes:**
- Existing appointments should not be affected by newly marked unavailable periods.

---

### User Story

**Title:**
_As a doctor, I want to update my profile with specialization and contact information, so that patients have up-to-date information._

**Acceptance Criteria:**
1. The doctor can access their profile settings.
2. The doctor can update specialization details.
3. The doctor can update contact information.
4. The system validates required fields before saving.
5. Updated profile information is visible to patients.

**Priority:** Medium  
**Story Points:** 3

**Notes:**
- Changes should be reflected immediately after saving.

---

### User Story

**Title:**
_As a doctor, I want to view patient details for upcoming appointments, so that I can be prepared._

**Acceptance Criteria:**
1. The doctor can access a list of upcoming appointments.
2. The doctor can view patient details associated with each appointment.
3. Patient information is displayed only for appointments assigned to the doctor.
4. The system protects patient data according to privacy requirements.
5. Patient details are available before the scheduled appointment time.

**Priority:** High  
**Story Points:** 5

**Notes:**
- Access to patient information must be restricted to authorized doctors.
- Patient data should be handled in compliance with privacy regulations.