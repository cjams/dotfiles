#!/bin/sh

me=$(notmuch config get user.primary_email)

# Mark messages from me as sent
notmuch tag -new +sent -- tag:new and from:$me

# Tag mailing list messages
notmuch tag +xsa +list -- tag:new and from:"/.*<security@xen.org>/"
notmuch tag +listinbox +unread +list -new -- tag:new and tag:xsa

notmuch tag +xen +list -- tag:new and to:xen-devel@lists.xenproject.org and not tag:xsa
notmuch tag +inbox +unread -new -- tag:new and tag:xen and to:$me
notmuch tag +listinbox +unread +list -new -- tag:new and tag:xen and not to:$me

notmuch tag +winpv +list -- tag:new and to:win-pv-devel@lists.xenproject.org
notmuch tag +inbox +unread -new -- tag:new and tag:winpv and to:$me
notmuch tag +listinbox +unread +list -new -- tag:new and tag:winpv and not to:$me

notmuch tag +lkml +list -- tag:new and to:linux-kernel@vger.kernel.org
notmuch tag +inbox +unread -new -- tag:new and tag:lkml and to:$me
notmuch tag +listinbox +unread +list -new -- tag:new and tag:lkml and not to:$me

notmuch tag +riscv +list -- tag:new and to:"/.*@lists.riscv.org/"
notmuch tag +inbox +unread -new -- tag:new and tag:riscv and to:$me
notmuch tag +listinbox +unread +list -new -- tag:new and tag:riscv and not to:$me

notmuch tag +sel4 +list -- tag:new and to:"/.*@sel4.systems/"
notmuch tag +inbox +unread -new -- tag:new and tag:sel4 and to:$me
notmuch tag +listinbox +unread +list -new -- tag:new and tag:sel4 and not to:$me

# finally, retag any remaining "new" messages "inbox" and "unread"
notmuch tag +inbox +unread -new -- tag:new
