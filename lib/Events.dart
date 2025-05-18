import 'package:flutter/material.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF6FA),
      appBar: AppBar(
        title: const Text("Fire Incident"),
        backgroundColor: Colors.teal[700],
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Event Category: Fire (Electrical)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Event Status: Under Control",
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
            const SizedBox(height: 24),

            // First row: Camera Details + Incident Image (1:2 ratio)
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildCameraDetailsCard(),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: _buildIncidentImageCard(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Second row: Precautions
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildPrecautionsCard(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraDetailsCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Image.asset(
            'assets/images/fire.jpg', // Replace with actual path
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildIncidentImageCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Camera ID: CAM_45", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Camera Type: CCTV", style: TextStyle(fontSize: 15)),
            SizedBox(height: 8),
            Text("Location: Platform 2 Exit", style: TextStyle(fontSize: 15)),
            SizedBox(height: 8),
            Text("Location Description: Near escalator, right side wall mount", style: TextStyle(fontSize: 15)),
            SizedBox(height: 8),
            Text("Incident Time: 4:00 p.m.", style: TextStyle(fontSize: 15)),
            SizedBox(height: 8),
            Text("Incident Description: Electrical short-circuit near ticket counter.", style: TextStyle(fontSize: 15)),
            SizedBox(height: 8),
            Text("Number of Casualties : 0", style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
  Widget _buildPrecautionsCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Precautions:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("• Use nearest fire extinguisher."),
            Text("• Evacuate area immediately."),
            Text("• Do not use elevators."),
            Text("• Alert emergency response team."),
            Text("• Shut off electrical supply if safe."),
          ],
        ),
      ),
    );
  }
}
