# Issue to File on castrojo/finpilot Repository

**Issue Title:**
Make template distribution-agnostic: Add support examples for Ubuntu/Debian and Arch

**Labels:** enhancement, documentation

**Issue Body:**

---

## Summary

The finpilot template is currently optimized for Fedora-based bootc images. To make it truly distribution-agnostic and support Debian/Ubuntu, Arch, and Fedora equally well, the template needs documentation improvements and example files for different distributions.

## Context

While adapting finpilot to create ubuntu-perfected (an Ubuntu bootc image), several distribution-specific differences were identified that make the template less accessible to users wanting to build images for non-Fedora distributions.

## Key Differences Between Distributions

### Package Managers

**Fedora/CentOS:** `dnf5 install -y package-name`
**Debian/Ubuntu:** Requires `apt-get update` before `apt-get install -y package-name`
**Arch:** `pacman -Syu --noconfirm package-name`

### Base Images

**Fedora:** `ghcr.io/ublue-os/bluefin:stable` or `quay.io/fedora/fedora-bootc:41`
**Ubuntu:** `ghcr.io/bootcrew/ubuntu-bootc:latest`
**Arch:** Community bootc images needed

### Desktop Environments

**Fedora:** `dnf5 group install "GNOME Desktop Environment"`
**Ubuntu:** `apt-get install -y ubuntu-desktop`
**Arch:** `pacman -Syu --noconfirm gnome gnome-extra`

### Package Repository Helpers

**Fedora:** COPR helpers (already in template)
**Ubuntu:** PPA helpers (not in template)
**Arch:** AUR helpers (not in template)

## Recommended Improvements

### High Priority

1. **Update build/10-build.sh** - Add commented examples for all three distributions:
```bash
# Fedora/CentOS (using dnf5)
# dnf5 install -y package-name

# Debian/Ubuntu (using apt)
# apt-get update
# apt-get install -y package-name

# Arch (using pacman)
# pacman -Syu --noconfirm package-name
```

2. **Update Containerfile comments** - Show all base image options:
```dockerfile
## Possible base images by distribution:
# Fedora-based: ghcr.io/ublue-os/bluefin:stable
# Ubuntu bootc: ghcr.io/bootcrew/ubuntu-bootc:latest
# Fedora base: quay.io/fedora/fedora-bootc:41
```

3. **Add build/README.md section** - Document distribution-specific package installation patterns

### Medium Priority

4. **Create example helper files:**
   - `build/ppa-helpers.sh.example` (Ubuntu)
   - `build/aur-helpers.sh.example` (Arch)

5. **Add desktop environment examples:**
   - `build/30-desktop-fedora.sh.example`
   - `build/30-desktop-ubuntu.sh.example`
   - `build/30-desktop-arch.sh.example`

6. **Update main README.md** - Add "Choosing Your Base Distribution" section

### Low Priority

7. Distribution detection in build scripts
8. Distribution-specific validation workflows

## Benefits

- **Accessibility:** Users can choose their preferred Linux distribution
- **Flexibility:** Easier to adapt template for any distribution
- **Learning:** See examples from multiple package managers
- **Community Growth:** Attracts users from different Linux communities

## Example Implementation

Reference implementation: [ubuntu-perfected](https://github.com/castrojo/ubuntu-perfected) - demonstrates Ubuntu-specific adaptations needed.

## Testing Criteria

When implementing:
- Each distribution example should use correct package manager syntax
- Base images should be tested and verified to work with bootc
- Desktop installations should result in working graphical environments
- Examples should follow distribution best practices

## Additional Notes

This enhancement would position finpilot as the go-to template for bootc images regardless of base distribution preference, expanding its utility beyond the Fedora/Universal Blue ecosystem.

---

**Instructions for filing this issue:**

1. Go to https://github.com/castrojo/finpilot/issues/new
2. Copy the issue title above
3. Copy the issue body (everything between the --- markers)
4. Add labels: `enhancement`, `documentation`
5. Submit the issue
