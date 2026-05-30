# MySQL Database Design – Think and Create
Structured, validated, and interrelated data works well in MySQL. Think of the core operational data for the clinic.

Create a section in your file titled:
```
## MySQL Database Design
```


### Table: clinic_locations

- id: INT, Primary Key, Auto Increment
- name: VARCHAR(100), Not Null
- address: VARCHAR(255), Not Null
- city: VARCHAR(80), Not Null
- phone: VARCHAR(20), Nullable *(validar formato en código)*
- email: VARCHAR(100), Nullable, Unique *(validar formato en código)*
- is_active: TINYINT(1), Not Null, Default 1
- created_at: TIMESTAMP, Not Null, Default CURRENT_TIMESTAMP

---

### Table: patients

- id: INT, Primary Key, Auto Increment
- document_type: VARCHAR(10), Not Null *(ej. DNI, PASSPORT)*
- document_number: VARCHAR(20), Not Null
- first_name: VARCHAR(100), Not Null
- last_name: VARCHAR(100), Not Null
- phone: VARCHAR(20), Nullable *(validar formato en código)*
- email: VARCHAR(100), Nullable, Unique *(validar formato en código)*
- birth_date: DATE, Nullable
- gender: ENUM('M','F','O','U'), Nullable
- address: VARCHAR(255), Nullable
- emergency_contact_name: VARCHAR(100), Nullable
- emergency_contact_phone: VARCHAR(20), Nullable
- registration_date: TIMESTAMP, Not Null, Default CURRENT_TIMESTAMP
- deleted_at: DATETIME, Nullable *(soft delete; NULL = paciente activo)*
- CONSTRAINT uq_patient_document UNIQUE (document_type, document_number)

---

### Table: doctors

- id: INT, Primary Key, Auto Increment
- first_name: VARCHAR(100), Not Null
- last_name: VARCHAR(100), Not Null
- specialty: VARCHAR(80), Not Null
- license_number: VARCHAR(30), Not Null, Unique
- phone: VARCHAR(20), Nullable
- email: VARCHAR(100), Nullable, Unique
- default_location_id: INT, Nullable, Foreign Key → clinic_locations(id)
- is_active: TINYINT(1), Not Null, Default 1
- deleted_at: DATETIME, Nullable *(soft delete; conserva historial de citas)*
- created_at: TIMESTAMP, Not Null, Default CURRENT_TIMESTAMP

---

### Table: admin

- id: INT, Primary Key, Auto Increment
- username: VARCHAR(50), Not Null, Unique
- password_hash: VARCHAR(255), Not Null *(nunca guardar texto plano)*
- full_name: VARCHAR(150), Not Null
- email: VARCHAR(100), Not Null, Unique
- role: ENUM('SUPER_ADMIN','RECEPTION','BILLING'), Not Null, Default 'RECEPTION'
- location_id: INT, Nullable, Foreign Key → clinic_locations(id)
- is_active: TINYINT(1), Not Null, Default 1
- last_login_at: DATETIME, Nullable
- created_at: TIMESTAMP, Not Null, Default CURRENT_TIMESTAMP

---

### Table: doctor_availability

- id: INT, Primary Key, Auto Increment
- doctor_id: INT, Not Null, Foreign Key → doctors(id) ON DELETE CASCADE
- location_id: INT, Not Null, Foreign Key → clinic_locations(id)
- day_of_week: TINYINT, Not Null *(0 = Domingo … 6 = Sábado)*
- start_time: TIME, Not Null
- end_time: TIME, Not Null
- slot_duration_minutes: INT, Not Null, Default 30
- is_active: TINYINT(1), Not Null, Default 1
- CONSTRAINT chk_availability_times CHECK (end_time > start_time)
- CONSTRAINT uq_doctor_day_location UNIQUE (doctor_id, location_id, day_of_week, start_time)

---

### Table: appointments

- id: INT, Primary Key, Auto Increment
- doctor_id: INT, Not Null, Foreign Key → doctors(id) ON DELETE RESTRICT
- patient_id: INT, Not Null, Foreign Key → patients(id) ON DELETE RESTRICT
- location_id: INT, Not Null, Foreign Key → clinic_locations(id)
- appointment_time: DATETIME, Not Null
- duration_minutes: INT, Not Null, Default 60
- status: INT, Not Null, Default 0 *(0 = Scheduled, 1 = Completed, 2 = Cancelled, 3 = No-show)*
- reason: VARCHAR(255), Nullable
- notes: TEXT, Nullable
- created_by_admin_id: INT, Nullable, Foreign Key → admin(id) ON DELETE SET NULL
- cancelled_at: DATETIME, Nullable
- created_at: TIMESTAMP, Not Null, Default CURRENT_TIMESTAMP
- updated_at: TIMESTAMP, Not Null, Default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
- CONSTRAINT uq_doctor_appointment_time UNIQUE (doctor_id, appointment_time)

---

### Table: medical_records

- id: INT, Primary Key, Auto Increment
- patient_id: INT, Not Null, Foreign Key → patients(id) ON DELETE RESTRICT
- doctor_id: INT, Not Null, Foreign Key → doctors(id) ON DELETE RESTRICT
- appointment_id: INT, Nullable, Unique, Foreign Key → appointments(id) ON DELETE SET NULL
- consultation_date: DATETIME, Not Null, Default CURRENT_TIMESTAMP
- diagnosis: TEXT, Nullable
- treatment: TEXT, Nullable
- created_at: TIMESTAMP, Not Null, Default CURRENT_TIMESTAMP

---

### Table: prescriptions

- id: INT, Primary Key, Auto Increment
- patient_id: INT, Not Null, Foreign Key → patients(id) ON DELETE RESTRICT
- doctor_id: INT, Not Null, Foreign Key → doctors(id) ON DELETE RESTRICT
- appointment_id: INT, Nullable, Foreign Key → appointments(id) ON DELETE SET NULL *(NULL = reposición o sin cita)*
- medication_name: VARCHAR(150), Not Null
- dosage: VARCHAR(80), Not Null
- frequency: VARCHAR(80), Not Null
- duration_days: INT, Nullable
- instructions: TEXT, Nullable
- issued_at: DATETIME, Not Null, Default CURRENT_TIMESTAMP
- expires_at: DATE, Nullable

---

### Table: payments

- id: INT, Primary Key, Auto Increment
- patient_id: INT, Not Null, Foreign Key → patients(id) ON DELETE RESTRICT
- appointment_id: INT, Nullable, Foreign Key → appointments(id) ON DELETE SET NULL
- amount: DECIMAL(10,2), Not Null
- currency: CHAR(3), Not Null, Default 'USD'
- payment_method: ENUM('CASH','CARD','TRANSFER','INSURANCE'), Not Null
- status: ENUM('PENDING','PAID','REFUNDED','FAILED'), Not Null, Default 'PENDING'
- paid_at: DATETIME, Nullable
- reference_number: VARCHAR(50), Nullable, Unique
- processed_by_admin_id: INT, Nullable, Foreign Key → admin(id) ON DELETE SET NULL
- created_at: TIMESTAMP, Not Null, Default CURRENT_TIMESTAMP

---

## Relaciones entre tablas (resumen)

```
clinic_locations ──┬── doctors.default_location_id
                   ├── doctor_availability.location_id
                   ├── appointments.location_id
                   └── admin.location_id

patients ──┬── appointments.patient_id
           ├── medical_records.patient_id
           ├── prescriptions.patient_id
           └── payments.patient_id

doctors ──┬── doctor_availability.doctor_id
          ├── appointments.doctor_id
          ├── medical_records.doctor_id
          └── prescriptions.doctor_id

appointments ──┬── medical_records.appointment_id (0..1)
               ├── prescriptions.appointment_id (0..1)
               └── payments.appointment_id (0..1)

admin ──┬── appointments.created_by_admin_id
        └── payments.processed_by_admin_id
```


# MongoDB Collection Design
**Ejemplo principal — receta enriquecida** (`engagementType: "prescription"`)

```json
{
  "_id": { "$oid": "64abc1234567890abcdef0123" },
  "schemaVersion": 1,
  "engagementType": "prescription",
  "mysqlPatientId": 12,
  "mysqlDoctorId": 3,
  "mysqlAppointmentId": 51,
  "mysqlPrescriptionId": 88,
  "tags": ["post-op", "pain-management", "controlled-substance"],
  "metadata": {
    "source": "web_portal",
    "locale": "es-PE",
    "signedElectronically": true,
    "ipAddress": "192.168.1.45"
  },
  "content": {
    "medication": "Paracetamol",
    "dosage": "500mg",
    "doctorNotes": "Tomar 1 tableta cada 6 horas con alimentos. Suspender si aparece rash.",
    "patientInstructions": "No combinar con alcohol. Completar el tratamiento de 5 días.",
    "refillCount": 2,
    "maxRefills": 3,
    "sideEffectsReported": [],
    "pharmacy": {
      "name": "Farmacia San Martín",
      "location": "Av. Arequipa 1200, Lima",
      "phone": "+51 1 555-0199",
      "preferredDelivery": false
    },
    "interactions": [
      { "drug": "Ibuprofeno", "severity": "moderate", "note": "Espaciar al menos 4 h" }
    ]
  },
  "attachments": [
    {
      "fileName": "receta-firmada-88.pdf",
      "mimeType": "application/pdf",
      "storageUrl": "s3://clinic-bucket/prescriptions/88/signed.pdf",
      "uploadedAt": { "$date": "2026-05-29T14:30:00Z" },
      "uploadedBy": "doctor:3"
    }
  ],
  "auditTrail": [
    {
      "action": "created",
      "by": "doctor:3",
      "at": { "$date": "2026-05-29T14:00:00Z" }
    },
    {
      "action": "sent_to_pharmacy",
      "by": "system",
      "at": { "$date": "2026-05-29T14:05:00Z" }
    }
  ],
  "createdAt": { "$date": "2026-05-29T14:00:00Z" },
  "updatedAt": { "$date": "2026-05-29T14:30:00Z" }
}
```

**Ejemplo — feedback del paciente** (`engagementType: "feedback"`)

```json
{
  "_id": { "$oid": "64def7890123456789012345" },
  "schemaVersion": 1,
  "engagementType": "feedback",
  "mysqlPatientId": 12,
  "mysqlAppointmentId": 51,
  "tags": ["satisfaction", "follow-up"],
  "content": {
    "rating": 4,
    "comment": "La atención fue excelente, pero la espera fue larga.",
    "wouldRecommend": true,
    "categories": ["wait_time", "staff_kindness"]
  },
  "createdAt": { "$date": "2026-05-30T09:15:00Z" }
}
```

**Ejemplo — log de check-in** (`engagementType: "activity_log"`)

```json
{
  "_id": { "$oid": "64ghi34567890123456789012" },
  "schemaVersion": 1,
  "engagementType": "activity_log",
  "mysqlPatientId": 12,
  "mysqlAppointmentId": 51,
  "content": {
    "event": "patient_check_in",
    "location": "reception_desk_2",
    "method": "qr_code",
    "notes": "Paciente llegó 10 min antes."
  },
  "auditTrail": [
    {
      "action": "check_in",
      "by": "admin:2",
      "at": { "$date": "2026-05-29T08:50:00Z" }
    }
  ],
  "createdAt": { "$date": "2026-05-29T08:50:00Z" }
}
```

**Ejemplo — mensaje doctor ↔ paciente** (`engagementType: "message"`)

```json
{
  "_id": { "$oid": "64jkl90123456789012345678" },
  "schemaVersion": 1,
  "engagementType": "message",
  "mysqlPatientId": 12,
  "mysqlDoctorId": 3,
  "mysqlAppointmentId": 51,
  "tags": ["pre-visit", "question"],
  "content": {
    "threadId": "thread-appt-51-p12-d3",
    "subject": "Duda sobre medicación post-cita",
    "messages": [
      {
        "senderType": "patient",
        "senderId": 12,
        "body": "¿Puedo tomar la pastilla si tengo dolor de estómago?",
        "sentAt": { "$date": "2026-05-29T16:00:00Z" },
        "readAt": { "$date": "2026-05-29T16:12:00Z" }
      },
      {
        "senderType": "doctor",
        "senderId": 3,
        "body": "Sí, pero siempre después de comer. Si el dolor persiste, agenda control.",
        "sentAt": { "$date": "2026-05-29T16:15:00Z" },
        "readAt": null
      }
    ],
    "status": "open"
  },
  "metadata": {
    "channel": "in_app",
    "priority": "normal"
  },
  "createdAt": { "$date": "2026-05-29T16:00:00Z" },
  "updatedAt": { "$date": "2026-05-29T16:15:00Z" }
}
```

---

## Relación MySQL ↔ MongoDB

```
MySQL prescriptions.id  ──►  clinical_engagements.mysqlPrescriptionId
MySQL patients.id         ──►  clinical_engagements.mysqlPatientId
MySQL appointments.id     ──►  clinical_engagements.mysqlAppointmentId
```

- **MySQL:** datos obligatorios, facturación, integridad referencial.
- **MongoDB:** notas libres, adjuntos, hilos de mensajes, feedback y logs sin alterar tablas SQL.
